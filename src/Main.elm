module Main exposing (..)

import Element exposing (..)
import Element.Background as Background
import Browser
import Browser.Dom
import Browser.Dom exposing (Viewport)
import Task

import Boilerplate as Bp

main = 
  Browser.element
    { init = init
    , update = update
    , view = \form -> layout [] (view form)
    , subscriptions = subscriptions}
  -- { init = init
  -- , update = update
  -- , view = \form -> layout [] (view form)
  -- }

type alias Model = Maybe Viewport

init :  () -> (Model, Cmd Msg)
init _ = (Nothing, Task.perform GotViewport Browser.Dom.getViewport)

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

type Msg = GotViewport Viewport

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    GotViewport vp ->
      (Just vp, Cmd.none)


-- page?
view : Model -> Element Msg
view model =
  case model of
    Nothing -> el [width fill, height fill, Background.color (rgb 0.1 0.1 0.12)] (text "")
    Just vp ->
      Bp.boilerplate vp (
          column [ width fill, centerX]
            [ Bp.whitetext "content goes here"
            ]
        )