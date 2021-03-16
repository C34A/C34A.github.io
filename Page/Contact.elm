module Contact exposing (..)

import Element exposing (..)
import Boilerplate exposing (..)

import CMarkdown

pageContent : Element msg
pageContent = 
  case (CMarkdown.toElements rawMd) of
    Err str -> whitetext str
    Ok content -> column [width fill] content


rawMd = """
# Contact

The best ways to contact me are generally by email or via discord.

Email: theo@seelye.net

Discord: C34A#4444
"""