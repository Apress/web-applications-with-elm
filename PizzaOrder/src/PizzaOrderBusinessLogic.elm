module  PizzaOrderBusinessLogic exposing (..)

import PizzaOrderModel exposing (..)
import List.Extra exposing (..)
import Maybe exposing (..)

calculateOrderNumber : Model -> String
calculateOrderNumber model =
  "2"

calculateOrder : PizzaOrder -> String
calculateOrder order =
  let
    o = order.quantity ++ "x " ++ order.pizzaname
  in
    """ [{"text":" """ ++ o ++ """ "}] """

calculateTotal : List PizzaOrder -> Float
calculateTotal l =
  let
    lp = List.map (\item -> item.total) l
  in
    List.foldl (+) 0.0 lp

calculateToppingsString : List Topping -> String
calculateToppingsString toppings =
  let
    l = List.map (\item -> " " ++ item.name) toppings
  in
    List.foldl (++) "" l

getPizzaById : String -> List Pizza -> Pizza
getPizzaById pizzaid plist =
  let
    pizza = find (\item -> item.id == pizzaid) plist
  in
    withDefault defaultpizza pizza

getOrdersPending : List PizzaOrder -> List PizzaOrder
getOrdersPending l =
  List.filter (\item -> item.pending == True) l

getOrdersReady : List PizzaOrder -> List PizzaOrder
getOrdersReady l =
  List.filter (\item -> item.pending == False && item.ready == True) l

customerString : Customer -> String
customerString c =
  c.name ++ "/" ++ c.address ++ "/" ++ c.telephone

resolveOrderDtoList : List OrderDto -> List PizzaOrder
resolveOrderDtoList l  =
  let
    p = defaultpizzaorder
  in
    List.map (\o -> {p | pizzaname = o.pizza
                           , pizzaid = ""
                           , quantity = o.quantity
                           , price = o.price
                           , total = o.total
                           , pending = o.pending
                           , ready = o.ready
                           , timestamp = o.id
                           , customer = o.customer
                           }) l

resolveOrderDto : OrderDto -> PizzaOrder
resolveOrderDto o =
  let
    p = defaultpizzaorder
  in
    {p | pizzaname = o.pizza
         , pizzaid = ""
         , quantity = o.quantity
         , price = o.price
         , total = o.total
         , pending = o.pending
         , ready = o.ready
         , timestamp = o.id
         , customer = o.customer
    }

resolveOrder : PizzaOrder -> OrderDto
resolveOrder o =
  OrderDto
        o.timestamp
        o.pizzaname
        o.quantity
        o.price
        o.total
        o.pending
        o.ready
        o.customer