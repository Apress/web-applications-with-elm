// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

const elmDiv = document.getElementById('elm-main'),
      elmApp = Elm.Hello.embed(elmDiv)
const elmDiv2 = document.getElementById('elm-main2'),
      elmApp2 = Elm.Hello2.embed(elmDiv2)
const elmDiv3 = document.getElementById('elm-main3'),
      elmApp3 = Elm.GamesFramework.embed(elmDiv3)
