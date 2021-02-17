module CMarkdown exposing (..)

import Boilerplate exposing (whitetext)
import CColors
import Element exposing (Element)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input
import Element.Region
import Html exposing (Attribute, Html)
import Html.Attributes
import Html.Attributes exposing (contenteditable)
import Markdown.Block as Block exposing (Block, Inline, ListItem(..), Task(..))
import Markdown.Html
import Markdown.Parser
import Markdown.Renderer
import Browser exposing (element)


toElements : String -> Result String (List (Element msg))
toElements markdown =
  markdown
    |> Markdown.Parser.parse
    |> Result.mapError (\error -> error |> List.map Markdown.Parser.deadEndToString |> String.join "\n")
    |> Result.andThen (Markdown.Renderer.render renderer)


renderer : Markdown.Renderer.Renderer (Element msg)
renderer =
  { heading = heading
  , paragraph =
    Element.paragraph
      [ Element.spacing 15 ]
  , thematicBreak = Element.none
  , text = \value -> Element.paragraph [] [ whitetext value ]
  , strong = \content -> Element.paragraph [ Font.bold, Font.color CColors.light ] content
  , emphasis = \content -> Element.paragraph [ Font.italic, Font.color CColors.light ] content
  , strikethrough = \content -> Element.paragraph [ Font.strike, Font.color CColors.light ] content
  , codeSpan = code
  , link =
    \{ title, destination } body ->
      Element.link []
        { url = destination
        , label =
          Element.paragraph
            [ Font.color CColors.lightblue
            , Element.htmlAttribute (Html.Attributes.style "overflow-wrap" "break-word")
            , Element.htmlAttribute (Html.Attributes.style "word-break" "break-word")
            ]
            body
        }
  , hardLineBreak = Html.br [] [] |> Element.html
  , image =
    \image ->
      case image.title of
        Just title ->
          Element.image [ Element.width Element.fill ] { src = image.src, description = image.alt }

        Nothing ->
          Element.image [ Element.width Element.fill ] { src = image.src, description = image.alt }
  , blockQuote =
    \children ->
      Element.paragraph
        [ Border.widthEach { top = 0, right = 0, bottom = 0, left = 10 }
        , Element.padding 10
        , Border.color CColors.lighter
        , Background.color CColors.dark
        ]
        children
  , unorderedList =
    \items ->
      Element.column [ Element.spacing 15 ]
        (items
          |> List.map
            (\(ListItem task children) ->
              Element.paragraph [ Element.spacing 5 ]
                [ Element.paragraph
                  [ Element.alignTop ]
                  ((case task of
                    IncompleteTask ->
                      Element.Input.defaultCheckbox False

                    CompletedTask ->
                      Element.Input.defaultCheckbox True

                    NoTask ->
                      Element.text "•"
                   )
                    :: Element.text " "
                    :: children
                  )
                ]
            )
        )
  , orderedList =
    \startingIndex items ->
      Element.column [ Element.spacing 15 ]
        (items
          |> List.indexedMap
            (\index itemBlocks ->
              Element.paragraph [ Element.spacing 5 ]
                [ Element.paragraph [ Element.alignTop ]
                  (Element.text (String.fromInt (index + startingIndex) ++ " ") :: itemBlocks)
                ]
            )
        )
  , codeBlock = codeBlock
  , table = Element.column []
  , tableHeader =
      Element.column
        [ Font.bold
        , Element.width Element.fill
        , Font.center
        , Font.color CColors.light
        ]
  , tableBody = Element.column []
  , tableRow = Element.row [ Element.height Element.fill, Element.width Element.fill ]
  , tableHeaderCell =
        \maybeAlignment children ->
            Element.paragraph
                tableBorder
                children
    , tableCell =
        \maybeAlignment children ->
            Element.paragraph
                tableBorder
                children
    , html = Markdown.Html.oneOf []
    }

rawTextToId : String -> String
rawTextToId rawText =
    rawText
        |> String.split " "
        |> String.join "-"
        |> String.toLower

tableBorder =
    [ Border.color (Element.rgb255 223 226 229)
    , Border.width 1
    , Border.solid
    , Element.paddingXY 6 13
    , Element.height Element.fill
    ]

heading : { level : Block.HeadingLevel, rawText : String, children : List (Element msg) } -> Element msg
heading { level, rawText, children } =
    Element.paragraph
        [ Font.size
            (case level of
                Block.H1 ->
                    36

                Block.H2 ->
                    24

                _ ->
                    20
            )
        , Font.bold
        , Boilerplate.coolfont
        , Element.Region.heading (Block.headingLevelToInt level)
        , Element.htmlAttribute
            (Html.Attributes.attribute "name" (rawTextToId rawText))
        , Element.htmlAttribute
            (Html.Attributes.id (rawTextToId rawText))
        ]
        children

code : String -> Element msg
code snippet =
  Element.el
    [ Background.color
      (Element.rgba 0 0 0 0.04)
    , Border.rounded 2
    , Element.paddingXY 5 3
    , Font.color CColors.light
    , Font.family
      [ Font.external
        { url = "https://fonts.googleapis.com/css?family=Source+Code+Pro"
        , name = "Source Code Pro"
        }
      ]
    ]
    (Element.text snippet)


codeBlock : { body : String, language : Maybe String } -> Element msg
codeBlock details =
  Element.paragraph
    [ Background.color (Element.rgba 0 0 0 0.03)
    , Element.htmlAttribute (Html.Attributes.style "white-space" "pre")
    , Element.htmlAttribute (Html.Attributes.style "overflow-wrap" "break-word")
    , Element.htmlAttribute (Html.Attributes.style "word-break" "break-word")
    , Element.padding 20
    , Font.color CColors.light
    , Font.family
      [ Font.external
        { url = "https://fonts.googleapis.com/css?family=Source+Code+Pro"
        , name = "Source Code Pro"
        }
      ]
    ]
    [ Element.text details.body ]
