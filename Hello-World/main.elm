module Hello exposing (..)

import Html exposing (text)

main : Html.Html msg
main =
    text "Hello World"


(++++) : number -> number -> number
(++++) a b =
  a+a+b+b
