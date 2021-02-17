module About exposing (..)

import Element exposing (..)
import Boilerplate exposing (..)

import CMarkdown

pageContent : Element msg
pageContent = 
  case (CMarkdown.toElements "Hello, ***World***!") of
    Err str -> whitetext str
    Ok content -> column [] content