module About exposing (..)

import Element exposing (..)
import Boilerplate exposing (..)

import CMarkdown

pageContent : Element msg
pageContent = 
  case (CMarkdown.toElements rawMd) of
    Err str -> whitetext str
    Ok content -> column [width fill] content


rawMd = """
# Welcome to my website!

I plan to use this to publish a bit more information about 
projects I've been working on, and perhaps other things at some
 point.


This site might be a bit broken. I'm pretty new to web development.

## About me

I am a young pacific-northwesterner with interests including software/game
 development and robotics.
"""