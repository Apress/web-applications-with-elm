module Tests exposing (all)

import Test exposing (..)
import Fuzz exposing (..)
import String
import Expect
import List exposing (..)
import ShellScriptLib exposing (..)
import TestChapter exposing (..)
import FixCode exposing (..)

all : Test
all =
    Test.concat
        [ shellscriptlib
        , fixcode
        ]

shellscriptlib : Test
shellscriptlib =
  describe "Tests for ShellScriptLib - an example library for fake shell scripts"
  [
    describe """The function getPositivesList takes a regex pattern
    and a string and returns positive patterns."""
    [ test "find at least one match" <|
        \() ->
          let
              fnlist =
                  getPositivesList
                    "example-[0-9]-[0-9].(txt|elm|json|js|html)"
                    """example-1-2.txt example-7-1.elm
                       example-6-9.json example-4-2.html"""
          in
              Expect.false "Expects match list not to be empty." (isEmpty fnlist)
    , test "find all matches" <|
        \() ->
          let
              fnlist =
                  getPositivesList
                    "example-[0-9]-[0-9].(txt|elm|json|js|html)"
                    """example-1-2.txt example-7-1.elm
                       example-6-9.json example-4-2.html"""
          in
              Expect.true "Expects match list count to be correct." (length fnlist == 4)
    ],
    describe """The function replaceText takes a regex pattern,
      a replacement string and a string and returns the changed text."""
    [ test "find the match and replaces it" <|
        \() ->
          let
              replaced =
                replaceText
                  "example-[0-9]-[0-9].(txt|elm|json|js|html)"
                  "code here..."
                  "example-1-2.txt example-7-1.elm"
          in
              Expect.true
                "Expects text to be replaced."
                (replaced == "code here... code here...")
    ]
  ]

fixcode : Test
fixcode =
  describe """Tests for FixCode -
    replace code example hints in a markdown file with code"""
  [
    describe """The function readMarkdownFile takes the name of a
      (fake) markdown file and returns the contents."""
    [ test "display testchapter.md" <|
        \() ->
          let
              fnlist =
                  getPositivesList
                    "example-[0-9]-[0-9].(txt|elm|json|js|html)"
                    """example-1-2.txt example-7-1.elm
                       example-6-9.json example-4-2.html"""
          in
              Expect.false "Expects match list not to be empty." (isEmpty fnlist)
    ],
    describe """The function replaceExampleCode takes a markdown 
      file name and returns the changed text"""
    [ test "finds the match and replaces it" <|
        \() ->
          let
              replaced =
                replaceText
                  "example-[0-9]-[0-9].(txt|elm|json|js|html)"
                  "code here..."
                  "example-1-2.txt example-7-1.elm"
          in
              Expect.true
                "Expects text to be replaced."
                (replaced == "code here... code here...")
    ]
  ]

-- lib_GetPositivesListDefaultPattern : Test
-- lib_GetPositivesListDefaultPattern =
--   describe "The function takes a string and returns positive patterns"
--   [ test "finds at least one match" <|
--       \() ->
--         let
--             fnlist =
--                 getgetPositivesListDefaultPattern
--                   "example-1-2.txt example-7-1.elm
--                       example-6-9.json example-4-2.html"
--         in
--             Expect.false "Expects match list not to be empty." (isEmpty fnlist)
--   , test "finds all matches" <|
--       \() ->
--         let
--             fnlist =
--                 getgetPositivesListDefaultPattern
--                   "example-1-2.txt example-7-1.elm
--                       example-6-9.json example-4-2.html"
--         in
--             Expect.true "Expects match list count to be correct." (length fnlist == 4)
--   ]
--
-- lib_ReplaceText : Test
-- lib_ReplaceText =
--   describe "The function takes a regex pattern, a replacement string
--             and a string and returns the changed text"
--   [ test "finds the match and replaces it" <|
--       \() ->
--         let
--             replaced =
--               replaceText
--                 "example-[0-9]-[0-9].(txt|elm|json|js|html)"
--                 "code here..."
--                 "example-1-2.txt example-7-1.elm"
--         in
--             Expect.true
--               "Expects text to be replaced."
--               (replaced == "code here... code here...")
--   ]
--
-- lib_ReplaceTextDefaultPattern : Test
-- lib_ReplaceTextDefaultPattern =
--   describe "The function takes a regex pattern, a replacement string
--             and a string and returns the changed text"
--   [ test "finds the match and replaces it" <|
--       \() ->
--         let
--             replaced =
--               replaceTextDefaultPattern
--                 "code here..."
--                 getTestChapter
--         in
--             Expect.true
--               "Expects text to be replaced."
--               (replaced == "code here...")
--   ]
