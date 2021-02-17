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


# This is a title


this is text


## this is h2


this is *more text*


- this
- is
- list
"""