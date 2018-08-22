module ShellScriptLib exposing (..)

import Regex exposing (..)
import List exposing (..)

replaceText : String -> String -> String -> String
replaceText pattern substitution text =
  text |>
    Regex.replace All (regex (pattern)) (\_ -> substitution)

getPositivesList : String -> String -> List String
getPositivesList pattern text =
  map.match <| find All (regex pattern) text
