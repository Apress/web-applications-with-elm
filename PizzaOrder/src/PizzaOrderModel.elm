module  PizzaOrderModel exposing (..)

import Time exposing (..)
import Navigation
import Http exposing (Error)
import Table exposing (State)

type Page =
  HomePage
  | OrdersPage

type alias Topping =
  { id: String
  , name: String
  }

type alias PizzaOrder =
  { pizzaname: String
  , pizzaid: String
  , toppings: List Topping
  , size: String
  , quantity: String
  , price: Float
  , total: Float
  , customer: String
  , timestamp: String
  , pending: Bool
  , ready: Bool
  }

type alias Customer =
    { name: String
    , address: String
    , telephone: String
    , ordered: List PizzaOrder
    , selected: PizzaOrder
    , time: String
    , amount: Float
    }

type alias Model  =
  { temporder: Customer
  , orders: List PizzaOrder
  , total: Float
  , currenttime: String
  , timestamp: String
  , flags: Flags
  , page : Page
  , history : List Navigation.Location
  , pizze: List Pizza
  , allorders: List OrderDto
  , status: String
  , customer: String
  , tableState : Table.State
  }

type alias OrderDto =
  { id: String
    , pizza: String
    , quantity: String
    , price: Float
    , total: Float
    , pending: Bool
    , ready: Bool
    , customer: String
  }

type alias Pizza =
  { id: String
    , name: String
    , price: String
    , description: String
  }

defaultpizza : Pizza
defaultpizza =
  Pizza "" "" "" ""

defaultpizzaorder : PizzaOrder
defaultpizzaorder =
  PizzaOrder "" "" [] "" "1" 0.0 0.0 "" "" True False

pizzalist : List Pizza
pizzalist =
  [ Pizza "1" "Calzone" "8.95" "Folded with bacon, ham, mozzarella and olives."
  , Pizza  "2" "Margherita" "8.95" "Classic mozzarella cheese and tomato sauce."
  , Pizza  "3" "Rustica" "9.95" "Vegetarian with mozzarella, tomato and rucola."
  , Pizza  "4" "Hawaiian" "9.95" "Smoked leg ham with pineapple with more mozzarella."
  ]

toppingslist : List Topping
toppingslist =
  [Topping "1" "Ham", Topping "2" "Cheese", Topping "3" "Olives"]

initialTempOrder : Customer
initialTempOrder =
  Customer "" "" "" [] defaultpizzaorder "" 0.00

initialModel : Model
initialModel =
  Model (Customer "" "" "" [] defaultpizzaorder "" 0.00) [] 0.0 "" "" (Flags 0) HomePage [] pizzalist [] "" "" (Table.initialSort "Name")

type Msg
  = NoOp
  | AddOrder
  | SelectPizza Pizza
  | SetPizza String
  | SetTopping String
  | RemoveTopping String
  | Orders (Result Http.Error (List OrderDto))
  | OrderCreated (Result Http.Error OrderDto)
  | Pizze (Result Http.Error (List Pizza))
  | ConfirmOrder
  | CancelOrder
  | InputName String
  | InputAddress String
  | InputTelephone String
  | IncrementQuantity
  | Quantity String
  | CurrentTime Time
  | UrlChanged Navigation.Location
  | NewUrl String
  | ToggleSelected PizzaOrder
  | SetTableState Table.State


type alias Flags =
  { dummyflag : Int
  }
