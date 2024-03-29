module Projects exposing (..)

import Element exposing (..)
import Element.Font exposing (..)

import CColors
import CMarkdown
import Element


colPage : List (Element msg) -> Element msg
colPage l = column [width fill, spacing 20] l

pageContent : Element msg
pageContent = 
    -- case (CMarkdown.toElements rawMd) of
    --     Err str -> whitetext str
    --     Ok content -> column [width fill] content
    colPage
        [ el [size 36, color CColors.light] (text "Projects")
        , project { name = "VM1", description = "retro virtual machine", url = "/project/vm1"}
        , project { name = "Untitled Space Game", description = "zero-G muliplayer first person shooter", url = "/project/usg"}
        ]

getProjectPage : String -> Element msg
getProjectPage proj = 
    case proj of
        "test" -> 
            tryMarkdown "This is a test page!"
        "vm1" -> colPage [
            tryMarkdown """
# VM1

## NOTE: this post is now pretty outdated, as this project has progressed a lot. Check out the github page for more up to date info!

This is the main project I am working on, currently.
VM1 is a very minimal virtual machine, inspired by Apple 2 era computers, and intended for retro game programming.
It's still pretty thoroughtly not done, but is technically turing complete in its current state.
"""
            , link [color CColors.lightblue, underline, size 18] {url = "https://github.com/C34A/vm1", label = Element.text "Github page"}
            , tryMarkdown """

## features
- simple instructionset (i am lazy)
- built-in assembler
- windowed output

## example

A short program that continuously prints out the alphabet:

```

set r0 65 ; 'A'

set r1 31167 ; screen start addr

set r2 32767 ; screen end + 1

set r4 91 ; 'Z' + 1

loop:

store r0 @r1 ; write to "pixel"

inc r1 1 ; next addr

inc r0 1 ; next char

jlt r0 r4 :test ; don't go past 'Z'

set r0 65

test:

jlt r1 r2 :loop ; if at end, draw and reset drawing pointer

draw

set r1 31167

jmp :loop

```

It isn't actually all on one line, for some reason the markdown library I'm using for this site is deleting all the newlines. 
dunno. I'm probably going to remake the site with gatsby or next.js or something at some point, so I don't *really* care.

![a screenshot](https://github.com/C34A/vm1/blob/master/res/screenshot.png?raw=true)
"""
            ]
        "usg" -> tryMarkdown """
![a screenshot](/res/usg_screenshot_small.png?raw=true)
# Untitled Space Game

This is a project I have been working on since about march of 2020, on and off. It was originally what I switched to working on for my projects in CS class when we went into lockdown.

Untitled Space Game (which definitely does need a name) is intended to be a multiplayer first person shooter, featuring novel zero-G movement mechanics. Its current state is very unpollished, but it does have the core gameplay features. Last time I was working on it, I got it to a state where multiple weapon options were mostly implemented.

Untitled Space Game is also currently the best showcase I have of my current 3D art skills. The art style of this game was intended to be a mix of current technologies as well as more sci-fi concepts but still rooted in what is known to be possible. I made almost all of the art assets for this game myself in blender, which I ended up learning a lot from.

I have mostly stopped working on this project however, since while I like the project I wasn't particularly enjoying using Unity, and the codebase was somewhat awkward to work with (which is entirely my fault...). If I do come back to it, I will probably move to a different engine such as Godot or Unreal (or something I make potentially), since most of the code could use being rewritten anyway.
"""
        _ -> Element.paragraph [] [tryMarkdown "Page not found!", link [color CColors.lightblue, underline] {url = "/projects", label = text "Return to projects page"}]

tryMarkdown text =
    case CMarkdown.toElements text of 
        Err str -> 
            el [Element.Font.color CColors.light] (Element.text ("ERROR: " ++ str))
        Ok content -> 
            colPage content

-- rawMd = "

type alias ProjData = 
    { name: String
    , description: String
    , url: String
    }

project : ProjData -> Element msg
project data = 
    link [] 
        { url = data.url
        , label = Element.column
            []
            [ el [ Element.Font.color CColors.light, Element.Font.size 32] (Element.text data.name) 
            , el [ Element.Font.color CColors.light, Element.Font.size 24] (Element.text data.description)  
            ]
        }