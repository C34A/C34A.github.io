module Resume exposing (..)

import Element exposing (..)
import Boilerplate exposing (..)

import CMarkdown

pageContent : Element msg
pageContent = 
  case (CMarkdown.toElements rawMd) of
    Err str -> whitetext str
    Ok content -> column [width fill] content


rawMd = """
# Resume

This is obviously a sanitized version of my resumé, without identifying information.
If you would like a copy of my full resumé, contact me.

## C34A

Aspiring software/game developer

### Programming languages:

proficient: Java, Godot Game Engine/GDScript, 
Unity Game Engine (C#), C++, Python, Rust, Elm

Experimented with: Web development, Android development

Operating systems: Windows, Linux (Ubuntu, Pop_OS, Arch, Fedora)

### Work experience:

#### Internship at bThere.ai - summer 2020
I interned at bThere.ai, an early stage startup doing SaaS for remote monitoring 
and control of robots. I specifically worked on their “bThere sensor nodes” and 
“bThere actuator nodes”, which are collections of ROS nodes written in python to 
read common sensors and interface with actuator hardware. The bThere sensor nodes 
can be found at: 
[https://github.com/bThere-ai/bthere_sensor_nodes](https://github.com/bThere-ai/bthere_sensor_nodes)

### Notable projects

#### VM1 - 2021, ONGOING 
A virtual machine and assembler written in rust, inspired by early consumer PCs such as the Apple 2 and Commodore 64. Currently in relatively early development. 
More info: https://github.com/C34a/vm1

#### Spectre - 2020, ONGOING (ish)
A 3D game engine written in modern C++ (being rewritten in rust), designed from the ground up for modularity and for effective utilization of high core-count processors. In very early development. More info: https://github.com/averysumner/Spectre

#### Unnamed Space Shooter - 2020, ONGOING (ish)
A 3D multiplayer first-person shooter game set in space featuring unique 6-degrees-of-freedom movement with realistic physics. Art style inspired by Sci-Fi movies such as 2001 and Ender’s Game, blended with realistic technologies. Made in Unity using C#.

#### Continyoom: racing game with time travel - LATE 2019 TO EARLY 2020
A racing game made in the Godot game engine along with three other students. This was the first semester project for my Projects in Computer Science class. The class simulates the experience of  working in the software industry, requiring the use of Agile development and git. The game is  similar to Mario Kart, however  you don’t control your speed but instead how fast you travel through time, including reversing time if you mess up. Project files: https://github.com/continyoom/continyoom2.

#### Robot control code for FTC robotics team - NOV. 2019 TO FEB.2020
Code for controlling my  FIRST FTC robotics team’s robot. Our robot had to pick up, move, and place 8”x4”x3” blocks autonomously and while tele-operated. This was mainly myself and one other programmer. Written in Java.  Project files:  https://github.com/ghs-robotics/SkyStone12788.
"""