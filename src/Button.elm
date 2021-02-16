module Button exposing (..)

-- Press buttons to increment and decrement a counter.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/buttons.html
--


import Browser
-- import Html exposing (Html, button, div, text)
-- import Html.Events exposing (onClick)

import Element exposing (..)
import Element.Input exposing (button)



-- MAIN


main =
  Browser.sandbox 
    { init = init
    , update = update
    , view = \form -> layout [] (view form)
    }



-- MODEL


type alias Model = Int


init : Model
init =
  0



-- UPDATE


type Msg
  = Increment
  | Decrement


update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1



-- VIEW


view : Model -> Element Msg
view model =
  row [ width fill, spacing 10 ]
    [ button [] 
        { onPress = Just Increment
        , label = text "+"} 
    , text (String.fromInt model)
    , button []
        { onPress = Just Decrement
        , label = text "-"}
    ]