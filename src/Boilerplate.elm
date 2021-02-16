module Boilerplate exposing (..)

import Element exposing (..)
import Element.Background as Background
import Browser
import Browser.Dom
import Browser.Dom exposing (Viewport)
import Element.Font as Font
import Element.Border as Border

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