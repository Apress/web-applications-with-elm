port module  PizzaOrderUpdate exposing (..)

import PizzaOrderModel exposing (..)
import PizzaOrderBusinessLogic exposing (..)
import Config exposing (..)

--import List.Extra exposing (..)
import Time.DateTime as DT exposing (..)
import Navigation
import Http
import Json.Decode as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Formatting as F exposing (..)
--import Task exposing (..)

--port initializejs : String -> Cmd msg

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    NoOp ->
      (model, Cmd.none)

    AddOrder ->
      let
        t = model.temporder
        to = model.temporder.ordered
        t_ = {initialTempOrder | ordered = t.selected :: to}
        m = Model {t_ | time = model.currenttime, amount = t.amount}
          model.orders
          t.amount
          model.currenttime
          model.timestamp
          model.flags
          model.page
          model.history
          model.pizze
          model.allorders
          model.status
          model.customer
          model.tableState
      in
        (m, Cmd.none)

    ConfirmOrder ->
      let
        to = model.temporder.ordered
        p = calculateTotal model.temporder.ordered
        to_ = List.append model.orders to
        m = Model
          initialTempOrder
          to_
          p
          model.currenttime
          model.timestamp
          model.flags
          model.page
          model.history
          model.pizze
          model.allorders
          model.status
          (customerString model.temporder)
          model.tableState
      in
        (m, postOrder (resolveOrder (Maybe.withDefault defaultpizzaorder (List.head to_))))

    CancelOrder ->
      (initialModel, Cmd.none)

    InputName name ->
      let
        t = model.temporder
        m = Model {t | name = name}
          model.orders
          model.total
          model.currenttime
          model.timestamp
          model.flags
          model.page
          model.history
          model.pizze
          model.allorders
          model.status
          model.customer
          model.tableState
      in
        (m, Cmd.none)

    InputAddress address ->
      let
        t = model.temporder
        m = Model {t | address = address}
          model.orders
          model.total
          model.currenttime
          model.timestamp
          model.flags
          model.page
          model.history
          model.pizze
          model.allorders
          model.status
          model.customer
          model.tableState
      in
        (m, Cmd.none)

    InputTelephone telephone ->
      let
        t = model.temporder
        m = Model {t | telephone = telephone}
          model.orders
          model.total
          model.currenttime
          model.timestamp
          model.flags
          model.page
          model.history
          model.pizze
          model.allorders
          model.status
          model.customer
          model.tableState
      in
        (m, Cmd.none)

    SelectPizza p ->
      (model, Cmd.none)

    SetPizza pizzaid ->
      let
        t = model.temporder
        s = t.selected
        pz = getPizzaById pizzaid model.pizze
        prz_ = Result.withDefault 0.00 (String.toFloat pz.price)
        prz = Result.withDefault 0.00 (String.toFloat ((F.print (F.roundTo 2) prz_)))
        tot_ = prz_ * (Result.withDefault 1.0 (String.toFloat s.quantity))
        tot = Result.withDefault 0.00 (String.toFloat ((F.print (F.roundTo 2) tot_)))
        s_ = {s | pizzaname = pz.name, price = prz, pizzaid = pz.id, total = tot, timestamp = model.timestamp}
        m = Model {t | selected = s_}
          model.orders
          model.total
          model.currenttime
          model.timestamp
          model.flags
          model.page
          model.history
          model.pizze
          model.allorders
          model.status
          model.customer
          model.tableState
      in
        (m, Cmd.none)

    SetTopping topping ->
      let
        t = model.temporder
        s = t.selected
        topp = Topping topping topping
        s_ = {s | toppings = topp :: s.toppings}
        m = Model {t | selected = s_}
          model.orders
          model.total
          model.currenttime
          model.timestamp
          model.flags
          model.page
          model.history
          model.pizze
          model.allorders
          model.status
          model.customer
          model.tableState
      in
        (m, Cmd.none)

    RemoveTopping topping ->
      let
        t = model.temporder
        s = t.selected
        s_ = {s | toppings = removeTopping topping s.toppings}
        m = Model {t | selected = s_}
          model.orders
          model.total
          model.currenttime
          model.timestamp
          model.flags
          model.page
          model.history
          model.pizze
          model.allorders
          model.status
          model.customer
          model.tableState
      in
        (m, Cmd.none)

    IncrementQuantity ->
      let
        t = model.temporder
        s = t.selected
        qu = toString ((Result.withDefault 0 (String.toInt s.quantity))+1)
        tot_ = s.price * Result.withDefault 1.0 (String.toFloat qu)
        tot = Result.withDefault 0.00 (String.toFloat ((F.print (F.roundTo 2) tot_)))
        s_ = {s | quantity  = qu, total = tot}
        m = Model {t | selected = s_}
          model.orders
          model.total
          model.currenttime
          model.timestamp
          model.flags
          model.page
          model.history
          model.pizze
          model.allorders
          model.status
          model.customer
          model.tableState
      in
        (m, Cmd.none)

    Quantity number ->
      let
        t = model.temporder
        s = t.selected
        s_ = {s | quantity = number}
        m = Model {t | selected = s_}
          model.orders
          model.total
          model.currenttime
          model.timestamp
          model.flags
          model.page
          model.history
          model.pizze
          model.allorders
          model.status
          model.customer
          model.tableState
      in
        (m, Cmd.none)

    Orders (Ok orderlist) ->
      ({model | allorders = orderlist, orders = resolveOrderDtoList orderlist}, Cmd.none)

    Orders (Err _) ->
      ({model | status = "Error getting orders"}, Cmd.none)

    Pizze (Ok pizzalist) ->
      ({model | pizze = pizzalist} ! [Cmd.none])

    Pizze (Err _) ->
      ({model | status = "Error getting orders"}, Cmd.none)

    OrderCreated (Ok _) ->
        ({model | status = "Order created"} ! [])

    OrderCreated (Err _) ->
      ({model | status = "Error creating order"} ! [])

    CurrentTime time ->
      let
        t = model.temporder
        currentplus = addMinutes (((List.length t.ordered)+1)*1) (fromTimestamp time)
        s = toString (DT.hour currentplus) ++ ":" ++ toString (DT.minute currentplus)
      in
        ({model | currenttime = s, timestamp = toString time} ! [ getOrderList ])

    UrlChanged location ->
      { model | page = (getPage location.hash) } ! []

    NewUrl url ->
      (model, Navigation.newUrl url)

    ToggleSelected p ->
      let
        ol = model.orders
        ol_ = List.filter (\item -> item.pizzaid /= p.pizzaid) ol
        p_ = {p | ready = True, pending = False}
        olchanged = p_ :: ol_
        m = Model
          model.temporder
          olchanged
          model.total
          model.currenttime
          model.timestamp
          model.flags
          model.page
          model.history
          model.pizze
          model.allorders
          model.status
          model.customer
          model.tableState
      in
        (m, patchOrder (resolveOrder p_))

    SetTableState newState ->
      {model | tableState = newState} ! [ Cmd.none ]

-- helper functions

--toggle : String -> PizzaOrder -> PizzaOrder
--toggle name p =
--   p

getPage : String -> Page
getPage hash =
  case hash of
      "#home" ->
          HomePage
      "#orders" ->
          OrdersPage
      _ ->
          HomePage

getOrderList : Cmd Msg
getOrderList =
  let
    url = urlOrderList
  in
    Http.send Orders <| Http.get url decodeOrderList

decodeOrderList : Decoder (List OrderDto)
decodeOrderList =
  map8 OrderDto
    (field "id" Decode.string)
    (field "pizza" Decode.string)
    (field "quantity" Decode.string)
    (field "price" Decode.float)
    (field "total" Decode.float)
    (field "pending" Decode.bool)
    (field "ready" Decode.bool)
    (field "customer" Decode.string)
  |> Decode.list

getPizzaList : Cmd Msg
getPizzaList =
  let
    url = urlPizzaList
  in
    Http.send Pizze <| Http.get url decodePizzaList

decodePizzaList : Decoder (List Pizza)
decodePizzaList =
  Decode.map4 Pizza
    (field "id" Decode.string)
    (field "name" Decode.string)
    (field "price" Decode.string)
    (field "description" Decode.string)
  |> Decode.list

decodeOrder : Decoder OrderDto
decodeOrder =
  map8 OrderDto
    (field "id" Decode.string)
    (field "pizza" Decode.string)
    (field "quantity" Decode.string)
    (field "price" Decode.float)
    (field "total" Decode.float)
    (field "pending" Decode.bool)
    (field "ready" Decode.bool)
    (field "customer" Decode.string)

postOrder : OrderDto -> Cmd Msg
postOrder order =
  Http.send OrderCreated <|
    Http.request
      { method = "POST"
      , headers = []
      , url = urlOrder
      , body = Http.jsonBody (encoderOrder order)
      , expect = Http.expectJson decodeOrder
      , timeout = Nothing
      , withCredentials = False
      }

patchOrder : OrderDto -> Cmd Msg
patchOrder order =
  Http.send OrderCreated <|
    Http.request
      { method = "PUT"
      , headers = []
      , url = urlOrderPut ++ order.id
      , body = Http.jsonBody (encoderOrder order)
      , expect = Http.expectJson decodeOrder
      , timeout = Nothing
      , withCredentials = False
      }

encoderOrder : OrderDto -> Encode.Value
encoderOrder order =
  Encode.object
    [ ("id", Encode.string order.id)
    , ("pizza", Encode.string order.pizza)
    , ("quantity", Encode.string order.quantity)
    , ("price", Encode.float order.price)
    , ("total", Encode.float order.total)
    , ("pending", Encode.bool order.pending)
    , ("ready", Encode.bool order.ready)
    , ("customer", Encode.string order.customer)
    ]

removeTopping : String -> List Topping -> List Topping
removeTopping topping toppings =
  let
    (t,_) = List.partition (\x -> x.name /= topping) toppings
  in
    t
