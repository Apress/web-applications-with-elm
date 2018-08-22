port module  PizzaOrder exposing (..)

import Navigation
import PizzaOrderModel exposing (..)
import PizzaOrderUpdate exposing (..)
import PizzaOrderView exposing (..)

import Time exposing (..)
import Task exposing (..)

main : Program (Maybe Flags) Model Msg
main =
  Navigation.programWithFlags UrlChanged
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

init : Maybe Flags -> Navigation.Location -> ( Model, Cmd Msg )
init flags location =
  let
    initialstate =
      case flags of
        Maybe.Just flags ->
          {initialModel | flags = (Flags flags.dummyflag), history = [location] }
        Nothing ->
          initialModel
  in
    (initialstate , Task.perform CurrentTime Time.now)

port setName : (String -> msg) -> Sub msg
port setAddress : (String -> msg) -> Sub msg
port setTelephone : (String -> msg) -> Sub msg
port setPizza : (String -> msg) -> Sub msg
port setTopping : (String -> msg) -> Sub msg
port removeTopping : (String -> msg) -> Sub msg
port setQuantity : (String -> msg) -> Sub msg

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch ([
    setName InputName
    , setAddress InputAddress
    , setTelephone InputTelephone
    , setPizza SetPizza
    , setTopping SetTopping
    , removeTopping RemoveTopping
    , setQuantity Quantity
  ])
