module Resume exposing (..)

import Element exposing (..)
import Boilerplate exposing (..)

import CMarkdown

import Html exposing (iframe)
import Html.Attributes exposing (src)
import Html.Attributes

pageContent : Element msg
pageContent = 
  case (CMarkdown.toElements rawMd) of
    Err str -> whitetext str
    Ok content -> 
      column 
        [ width fill ] 
        ( content ++ 
          [ Element.html 
            ( Html.iframe 
              [ src "/res/internet_resume_2021-03-03.pdf"
              , Html.Attributes.style "width" "100%"
              , Html.Attributes.style "height" "40rem"] 
              []
            ) 
          ]
        )


rawMd = """
# Resume

This is obviously a sanitized version of my resumé, without identifying information.
If you would like a copy of my full resumé, contact me.
"""