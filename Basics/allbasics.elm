module AllBasics exposing (..)

import String exposing (..)
import Debug exposing (..)

debuggerTestString : String -> Int
debuggerTestString s =
  length (log "s" s)

--debuggerTestCrash =
--  crash "Not implemented"

charToUpper : Char -> String -> String
charToUpper c s =
  s ++ (fromChar c |> toUpper)

isBool : Bool
isBool = True

character : Char
character = 'a'

varassign_to_tuple : ( String, number )
varassign_to_tuple =
  let
    s1 : String
    s1 =
      "hello world"

    s2 : number
    s2 =
      42
  in
    (s1,s2) -- tuple

l1 : List Int
l1 = List.range 1 4

l2 : List number
l2 = [1,2,3,4]

l3 : List number
l3 = 1 :: [2,3,4]

l4 : List number
l4 = 1 :: 2 :: 3 :: 4 :: []

type alias ModelInt = Int

multiplyAndConcatenate : List number -> number -> String -> String
multiplyAndConcatenate list multi s =
  toString (addNumbers list * multi) ++ s

addNumbers : List number -> number
addNumbers list =
  List.foldr (+) 0 list

immutableTest : number
immutableTest =
  let
    a = 42
  in
    a

addMultiplyNumbersListFirst : List number -> number -> number
addMultiplyNumbersListFirst list m =
  addNumbers list * m

addMultiplyNumbers : number -> List number -> number
addMultiplyNumbers m list =
  addNumbers list * m

doublerList : List number -> number
doublerList =
  addMultiplyNumbers 2

multiplyNumbers : number -> number -> number
multiplyNumbers multiplicator value  =
  multiplicator * value

doubler : number -> number
doubler =
  multiplyNumbers 2

(++*) : List number -> number -> number
(++*) list multiplicator =
  case list of
    [] -> 0
    _ -> List.foldr (+) 0 list * multiplicator

returnOnly42 : number
returnOnly42 =
  42


type alias ComposedType =
  {
    x: Int,
    y: Int,
    keypressed: Bool
  }

firstListItem : List a -> Maybe a
firstListItem l =
  List.head l

anyToString : Maybe a -> String
anyToString arg =
  case arg of
    Just arg -> toString arg
    Nothing -> "no value"

callFunction : (a -> b) -> a -> b
callFunction func arg =
  func arg

callWithFunc : number
callWithFunc =
  callFunction (\n -> n*n) 5

callWithValue : number
callWithValue =
  let
    f = \n -> n*n
  in
    callFunction f 5

type Pizza = Calzone | Margherita | QuattroStagione | UnknownPizza
type PizzaWithOrders
  = CalzoneO Int
  | MargheritaO Int
  | QuattroStagioneO Int

getPizzaFromString : String -> Maybe Pizza
getPizzaFromString p =
  case p of
    "Calzone"
      -> Just Calzone
    "Margherita"
      -> Just Margherita
    "Quattro Stagione"
      -> Just QuattroStagione
    _
      ->  Nothing

choosePizza : Pizza -> String
choosePizza p =
  case p of
    Calzone
      -> "Pizza chosen: " ++ toString p
    Margherita
      -> "Pizza chosen: " ++ toString p
    _
      ->  "We don't serve this pizza"

choosePizzaIf : Pizza -> String
choosePizzaIf p =
  if p == Calzone then
    "Pizza chosen: " ++ toString p
  else if p == Margherita then
    "Pizza chosen: " ++ toString p
  else
    "We don't serve this pizza"

pizzaOrders : ( Pizza, number )
pizzaOrders =
    let
      p = Calzone
      n = 5
    in
      (p,n)

getPizzaOrders : Pizza -> (Pizza -> number) -> ( Pizza, number )
getPizzaOrders p calcfunction =
    let
      n = calcfunction p
    in
      (p,n)

getPizzaOrdersO : PizzaWithOrders -> Int
getPizzaOrdersO p =
    case p of
      CalzoneO n -> n
      MargheritaO n -> n
      QuattroStagioneO n -> n

calculatePizzaOrders : Pizza -> number
calculatePizzaOrders p =
  if  p == Calzone then
    5
  else
    0

pizzaLeft : Maybe Pizza -> number
pizzaLeft p =
  case p of
    Just Calzone
      -> 10
    _
      -> 0

-- addPizza : List Pizza -> List Pizza
addPizza : List Pizza -> Pizza -> List Pizza
addPizza l p =
  p :: l

addPizzaOrdered : List Pizza -> List Pizza -> List Pizza
addPizzaOrdered l p =
  l ++ p

firstPizza : List Pizza -> Maybe Pizza
firstPizza l =
  case l of
    head :: tail ->
      Just head
    [] -> Nothing

pizzaOnMenuTuple : ( Pizza, Pizza )
pizzaOnMenuTuple = (Calzone, QuattroStagione)

pizzaOnMenuList : List Pizza
pizzaOnMenuList = [Calzone, QuattroStagione]

pizzaOnMenuRecord : { pz1 : Pizza, pz2 : Pizza }
pizzaOnMenuRecord = {pz1 = Calzone, pz2 = QuattroStagione}

getPizzaTupleAsString : (Pizza, Pizza) -> String
getPizzaTupleAsString t =
  let
    (pz1, pz2) = t
  in
    toString pz1 ++ ", " ++ toString pz2

getPizzaRecordAsString : { a | pz1 : Pizza, pz2 : Pizza } -> String
getPizzaRecordAsString r =
  let
    {pz1, pz2} = r
  in
    toString pz1 ++ ", " ++ toString pz2

getPizzaListAsString : List Pizza -> String
getPizzaListAsString l =
  case l of
    [pz1,pz2] ->
      toString pz1 ++ "," ++ toString pz2
    [pz1] ->
      toString pz1
    pz1 :: pz2 :: _ ->
      toString pz1 ++ "," ++ toString pz2 ++ " ... and more"
    [] ->
      "List empty"

changeImmutableData : number -> number
changeImmutableData n =
  let
    p = n+1
  in
    p

type alias Event =
  { timestamp: Int
  , eventname: String
  }

type alias EventDescription a =
  { title : String
  , text : String
  , attachment : a
  }

type alias Model  =
  { xpos : Int
  , ypos : Int
  , numbertones: Int
  , backgroundimage: String
  , events: List Event
  }

getEventAttachment : EventDescription (List String) -> List String
getEventAttachment ev =
  ev.attachment

getEventDescriptionUnitType : EventDescription () -> String
getEventDescriptionUnitType ev =
  ev.title

printString =
  let
    ev = {title="title",text = "text", attachment = ()}
  in
    getEventDescriptionUnitType ev

ev = {timestamp = 12345, eventname = "eventname"}
m = { xpos = 0, ypos = 0, numbertones = 1, backgroundimage = "bg.png", events = [ev]}
