module  PizzaOrderView exposing (..)

import PizzaOrderModel exposing (..)
import PizzaOrderBusinessLogic exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Table exposing (..)
import Formatting as F exposing (..)

view : Model -> Html Msg
view model =
  div [] [
    renderNavbar model
    , renderPage model
  ]

renderNavbar : Model -> Html Msg
renderNavbar model =
  case model.page of
      HomePage ->
        div [] [
            div [class "container-fluid topbar"] [
              nav [id "topbar", class "navbar navbar-expand-lg navbar-light bg-faded"] [
                div [class "logotext mb-0"] [img [src "/static/images/pizza-icon.png", class "logo"] [], text "       Pizza Cut"]
              , div [id "navbarNav", class "collapse navbar-collapse"] [
                  ul [class "navbar-nav"] [
                    li [class "nav-item"] [
                      div [class "activetab"] [text "Take Order"]
                    ]
                    , li [class "nav-item"] [
                      a [class "nav-link inactivetab", href "#orders", onClick (NewUrl "/#orders") ] [text "Orders"]
                    ]
                  ]
                ]
              ]
            ]
          ]

      OrdersPage ->
        div [] [
                    div [class "container-fluid topbar"] [
                      nav [id "topbar", class "navbar navbar-expand-lg navbar-light bg-faded"] [
                        div [class "logotext mb-0"] [img [src "/static/images/pizza-icon.png", class "logo"] [], text "       Pizza Cut"]
                      , div [id "navbarNav", class "collapse navbar-collapse"] [
                          ul [class "navbar-nav"] [
                            li [class "nav-item"] [
                              a [class "nav-link inactivetab", href "/" , onClick (NewUrl "/home") ] [text "Take Order"]
                            ]
                            , li [class "nav-item"] [
                              div [class "activetab"] [text "Orders"]
                            ]
                          ]
                        ]
                      ]
                    ]
                   ]

renderPage : Model -> Html Msg
renderPage model =
  case model.page of
    HomePage ->
      div [class "container-fluid pagebody"] [
        div [class "row"] [
          div [class "col-3 border border-dark rounded mt-3 ml-4 mr-5"][
            div [class "mx-auto titlefixed d-flex justify-content-center"] [span [] [text "PIZZA"]]
            , Html.form [] [
              div [class "form-group"] [
                renderPizzaSpinner model
                , renderToppingSelect model.temporder.selected
                , div [class "input-group addorderbuttonwrapper"] [
                  button [class ("btn btn-success btn-sm addorderbutton" ++ (defineAddOrderButtonState model.temporder.selected)), type_ "button", onClick AddOrder] [text "ADD TO CUSTOMER ORDER"]
                ]
              ]
            ]
          ]
          , div [class "col-3 border border-dark rounded mt-3 mr-4"] [
            div [class "mx-auto titlefixed d-flex justify-content-center"] [text "CUSTOMER"]
            , Html.form [] [
               div [class "form-group"] [
                 div [class "row customerformrow"] [
                    div [class"col-xs-12 col-sm-12 col-md-12 col-lg-12"] [
                      div [class "customerformfieldwrapper"] [
                        label [for "name"] [text "Name"]
                        , input [id "name", class "form-control"] []]
                    ]
                 ]
                 , div [class "row customerformrow"] [
                    div [class"col-xs-12 col-sm-12 col-md-12 col-lg-12"] [
                       div [class "customerformfieldwrapper"] [
                         label [for "address"] [text "Street Address"]
                         , input [id "address", class "form-control"] []]
                    ]
                 ]
                 , div [class "row customerformrow"] [
                     div [class"col-xs-12 col-sm-12 col-md-12 col-lg-12"] [
                       div [class "customerformfieldwrapper"] [
                         label [for "telephone"] [text "Telephone"]
                         , input [id "telephone", class "form-control"] []]
                     ]
                  ]
               ]
            ]
          ]
        ]
        , div [class "row"] [
          div [class "col-2"] []
          , div [class "col-3 mt-3 mr-4"] [
              div [class "mx-auto titlefixed d-flex justify-content-center"] [
                span [] [text "TEMPORARY ORDER"]
                , span [class "badge badge-success badge-pill orderbadge"] [text (toString (List.length model.temporder.ordered))]
              ]
              , renderList model.temporder.ordered
              , renderOrderFooter model.temporder.ordered
              , div [class "input-group addorderbuttonwrapper"] [
                button [class ("btn btn-success btn-sm addorderbutton " ++ (defineConfirmOrderButtonState model.temporder)), type_ "button", onClick ConfirmOrder] [text "PLACE ORDER"]
              ]
              , div [class "input-group addorderbuttonwrapper"] [
                button [class ("btn btn-success btn-sm addorderbutton"), type_ "button", onClick CancelOrder] [text "CANCEL ORDER"]
              ]
          ]
        ]
      ]

    OrdersPage ->
      div [class "container-fluid pagebody"] [
          div [class "row"] [
              div [class "col-3 mt-3 ml-4 mr-5"][
                  div [class "mx-auto titlefixed d-flex justify-content-center"] [span [] [text "TODO"]]
                  , renderOrdersTodo (getOrdersPending model.orders) model.tableState
              ]
              , div [class "col-3 mt-3 ml-4 mr-5"][
                  div [class "mx-auto titlefixed d-flex justify-content-center"] [span [] [text "DONE"]]
                  , renderOrdersDone  (getOrdersReady model.orders) model.tableState
              ]
          ]
       ]

renderToppingSelect : PizzaOrder -> Html Msg
renderToppingSelect p =

  div [class "", id "toppingsselect"] [
    div [class "mx-auto titlefixed d-flex justify-content-center"] [text "ADDITIONAL TOPPINGS"]
    , renderToppingList toppingslist
  ]

renderPizzaSpinner : Model -> Html Msg
renderPizzaSpinner m =
  div [class "input-group", id "pizzaspinner"] [
      span [class "input-group-btn btn-group-sm"] [
        button [class "btn btn-success", type_ "button", attribute "data-action" "decrementQtyPizza"] [text "-"]
      ]
      , div [class "inputspinner"]  [input [name "quantity", type_ "text", class "form-control text-center", value m.temporder.selected.quantity, attribute "min" "1"] []]
      , span [class "input-group-btn btn-group-sm"] [
        button [class "btn btn-success", type_ "button", onClick IncrementQuantity] [text "+"]
    ]
    , div [class "input-group", id "pizzadropdownwrapper"] [
        div [class "dropdown pizzadropdown", id "pizzadropdownmenu"] [
          button [class "btn btn-success btn-sm dropdown-toggle pizzadropdownbutton", type_ "button", id "dropdownMenuButton", attribute "data-toggle" "dropdown", attribute "aria-haspopup" "true", attribute  "aria-expanded" "false"] [text "Select Pizza"]
          , div [class "dropdown-menu pizzadropdownmenu", attribute "aria-labelledby" "dropdownMenuButton"] [
            renderPizzaList m.pizze
          ]
      ]
    ]
    , div [] [
      span [] [text "Selected: "]
      , span [class "selectedpizza"] [text (m.temporder.selected.pizzaname ++ " " ++ (toString m.temporder.selected.price))]
    ]
  ]

renderPizzaList : List Pizza -> Html msg
renderPizzaList p =
  div []
    (List.map (\item -> button [class "dropdown-item", type_ "button", attribute "data-pizzaid" item.id] [text (item.name ++  " " ++ item.price)]) p)

renderToppingList : List Topping -> Html msg
renderToppingList l =
    div []
      (List.map (\item -> renderToppingListItem item) l)

renderToppingListItem : Topping -> Html msg
renderToppingListItem t =
    div [class "form-check"] [
        input [class "form-check-input", type_ "checkbox", checked False, value t.name, id t.id] []
        , label [class "form-check-label", for t.id] [text t.name]
    ]

renderList : List PizzaOrder -> Html msg
renderList l =
  div []
    (List.map (\item -> div [] [ text (item.quantity ++ "x " ++ item.pizzaname ++ "; " ++ calculateToppingsString (item.toppings)) ]) l)

renderOrderFooter : List PizzaOrder -> Html Msg
renderOrderFooter l =
  let
    total = calculateTotal l
  in
    div []
      ([span [] [text ("TOTAL: " ++ ((print (F.roundTo 2) total)))]])

renderOrdersTodo : List PizzaOrder -> Table.State -> Html Msg
renderOrdersTodo l tablestate =
  Table.view tableconfig tablestate l

tableconfig : Table.Config PizzaOrder Msg
tableconfig =
  Table.customConfig
    { toId = .pizzaid
    , toMsg = SetTableState
    , columns =
        [ checkboxColumn
        , Table.stringColumn "Name" .pizzaname
        , Table.floatColumn "Total" .total
--        , Table.customColumn "Done" .ready
        ]
    , customizations =
        { defaultCustomizations | rowAttrs = toRowAttrs }
    }

toRowAttrs : PizzaOrder -> List (Attribute Msg)
toRowAttrs p =
  [ onClick (ToggleSelected p)
--  , style [ ("background", if sight.selected then "#CEFAF8" else "white") ]
  ]


checkboxColumn : Table.Column PizzaOrder Msg
checkboxColumn =
  Table.veryCustomColumn
    { name = "Ready"
    , viewData = viewCheckbox
    , sorter = Table.unsortable
    }


viewCheckbox : PizzaOrder -> Table.HtmlDetails Msg
viewCheckbox {ready} =
  Table.HtmlDetails []
    [ input [ type_ "checkbox" ] []
    ]

renderOrdersDone : List PizzaOrder -> Table.State -> Html Msg
renderOrdersDone l tablestate =
  Table.view tableconfigDone tablestate l

tableconfigDone : Table.Config PizzaOrder Msg
tableconfigDone =
  Table.customConfig
    { toId = .pizzaid
    , toMsg = SetTableState
    , columns =
        [ Table.stringColumn "Name" .pizzaname
        , Table.floatColumn "Total" .total
        ]
    , customizations =
        { defaultCustomizations | rowAttrs = toRowAttrsDone }
    }

toRowAttrsDone : PizzaOrder -> List (Attribute Msg)
toRowAttrsDone p =
  [
--  , style [ ("background", if sight.selected then "#CEFAF8" else "white") ]
  ]

defineAddOrderButtonState : PizzaOrder -> String
defineAddOrderButtonState selected =
  case String.isEmpty selected.pizzaname  of
    True -> " disabled"
    False -> ""

defineConfirmOrderButtonState : Customer -> String
defineConfirmOrderButtonState customer =
  let
    pname = String.isEmpty customer.name
    paddress = String.isEmpty customer.address
    ptelephone = String.isEmpty customer.telephone
    plistcount = List.isEmpty customer.ordered
    predicate = pname || paddress || ptelephone || plistcount
  in
    case predicate  of
      True -> " disabled"
      False -> ""