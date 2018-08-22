module PizzaOrderTest exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)

import PizzaOrderBusinessLogic exposing (..)
import PizzaOrderModel exposing (..)

--suite : Test
--suite =
--    todo "Implement our first test. See http://package.elm-lang.org/packages/elm-community/elm-test/latest for how to do this!"

testpizzaorder : PizzaOrder
testpizzaorder =
  PizzaOrder "Rustica" "" [] "" "3" 9.95 29.85 "Joe/High Street/0712 334455" "1523224578" False True

testpizzaorderdto : OrderDto
testpizzaorderdto =
  OrderDto "1523224578" "Rustica" "3" 9.95 29.85 False True "Joe/High Street/0712 334455"

suite : Test
suite =
    describe "Pizza Order Test Suite"
        [
           describe "BusinessLogic"
              [ test "calculateToppingsString" <|
                    \() ->
                      Expect.equal " Olives Cheese Ham" (calculateToppingsString toppingslist)
                , test "resolveOrder PizzaOrder -> OrderDto" <|
                    \() ->
                      Expect.equal testpizzaorderdto (resolveOrder testpizzaorder)
                , test "resolveOrderDto OrderDto -> PizzaOrder" <|
                                    \() ->
                                      Expect.equal testpizzaorder (resolveOrderDto testpizzaorderdto)
              ]
        ]

