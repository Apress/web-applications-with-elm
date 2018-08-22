module Chapters exposing (..)

getChapter : String -> String
getChapter name =
  case name of
    "chapter-7" ->
      """The source code for this book has an example in the directory *Examples/Elm-Electron*. Open a command line in that directory and run the following command:

      ###### Listing 7.1 Run Electron example

      ```
      example-2-01.txt
      ```

      This will start the Electron application with our example. You will recognize it: it is the application from Chapter 7. Let's now examine how we can implement this and I will explain how to start from scratch. As always you can follow along and have a look at the finished example files in the above mentioned directory.

      I assume that Electron is installed on your machine. Their [website](http://electron.atom.io/) has download links for all platforms to install Electron globally or you can use the pre-built package on [Npm](https://www.npmjs.com/package/electron) for a local install as the example does.

      First we have to create a folder for the application and create a *package.json* file in it. The following excerpt omits some key-value pairs that are not essential for the example.

      ###### Listing 7.2 Package.json

      ```{.json .numberLines}
      example-2-03.elm
      ```
      """

    _ -> "ERROR"
