port module Spelling exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String

someWork =
  "anystring"

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL

type alias Model =
  { word : String
  , suggestions : String
  }

init : (Model, Cmd Msg)
init =
  (Model "" "", Cmd.none)


-- UPDATE

type Msg
  = Change String
  | Check
  | Suggest (String)


port check : String -> Cmd msg

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Change newWord ->
      ( Model newWord "", Cmd.none )

    Check ->
      ( model, check model.word )

    Suggest newSuggestions ->
      ( Model model.word newSuggestions, Cmd.none )


-- SUBSCRIPTIONS

port suggestions : (String -> msg) -> Sub msg

subscriptions : Model -> Sub Msg
subscriptions model =
  suggestions Suggest


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [
    ]
