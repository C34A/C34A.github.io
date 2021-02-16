module Main exposing (..)

import Element exposing (..)
import Element.Input exposing (button)
import Element.Font as Font
import Element.Background as Background
import Browser
import Browser.Dom
import Element.Border as Border
import Browser.Dom exposing (Viewport)
import Task
import String exposing (toInt)

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

type Msg = Increment 
         | Decrement 
         | GotViewport Viewport

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Increment ->
      (model, Cmd.none)
    Decrement ->
      (model, Cmd.none)
    GotViewport vp ->
      (Just vp, Cmd.none)

-- buttons
-- view : Model -> Element Msg
-- view model =
--   column [ width fill, centerX, spacing 10 ]
--     [ button [] 
--       { onPress = Just Increment
--       , label = text "+"} 
--     , text (String.fromInt model)
--     , button []
--       { onPress = Just Decrement
--       , label = text "-"}
--     ]

-- page?
view : Model -> Element Msg
view model =
  case model of
    Nothing -> el [width fill, height fill, Background.color (rgb 0.1 0.1 0.12)] (text "")
    Just vp ->
      el 
        [ centerX
        , Background.color (rgb 0.1 0.1 0.12)
        , width fill
        , height fill
        ] (
          boilerplate vp (
              column [ width fill, centerX]
                [ whitetext "content goes here"
                ]
            )
        )

whitetext : String -> Element msg
whitetext words =
  el [Font.color (rgb 1 1 1), coolfont] ( text words)


boilerplate : Viewport -> Element msg -> Element msg
boilerplate vp content = 
  let
    aspect = vp.viewport.y / vp.viewport.x
  in
    row [width fill, height fill]
      [ column 
          -- [ width (percentX vp 20.0)
          [ width (px 300)
          , height fill
          , Background.color (rgb 0.2 0.2 0.2)
          ]
          [ el [padding 20] (image 
              [ centerX
              -- , Border.rounded 128
              , Border.glow (rgb 255 255 255) 10
              ]
              { src = "https://source.unsplash.com/random/256x256"
              , description = ""
              }
            )
            
          , el 
              [ centerX
              , coolfont
              , Font.size 24
              ]
              (whitetext "C34A") 
          ]
      , el [alignTop] content
      ]

percentX : Viewport -> Float -> Length
percentX vp pct =
    px (round (vp.viewport.x * pct / 100.0))

percentY : Viewport -> Float -> Length
percentY vp pct =
    px (round (vp.viewport.y * pct / 100.0))

coolfont = 
  Font.family 
    [ Font.external 
      { name = "Quicksand"
      , url = "https://fonts.googleapis.com/css2?family=Quicksand&display=swap"
      }
    ]