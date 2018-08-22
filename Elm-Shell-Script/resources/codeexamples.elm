module CodeExamples exposing (..)

getCodeExample : String -> String
getCodeExample name =
  case name of
    "example-2-01.txt" ->
      """$ elm
      Elm Platform 0.18.0 - a way to run all Elm tools

      Usage: elm <command> [<args>]

      Available commands include:
        make      Compile an Elm file or project into JS or HTML
        package   Manage packages from <http://package.elm-lang.org>
        reactor   Develop with compile-on-refresh and time-travel debugging
        repl      A REPL for running individual expressions
      """

    "example-2-03.elm" ->
      """module Hello exposing (..)
      import Html exposing (..)

      type Msg = Change String | Check | Suggest (List String)

      main =
        text 'Hello World'

      update msg model =
        case msg of
          Change m -> ( m, Cmd.none )

      view model =
        div [][ input [ onInput Change ] [],
          button [ onClick Check ] [ text 'Check' ],
          div [] [ text (String.join ', ' model.suggestions) ]
        ]
      """

    _ -> "ERROR"
