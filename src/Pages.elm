module Pages exposing (..)

import Element exposing (..)
import Url
import Url.Parser as UP exposing (Parser, (</>), oneOf, s, string, top)

import About
import Resume
import Contact
import Projects

type Route
  = About
  | Resume
  | Contact
  | Projects
  | Project String
  | NotFound

parseRoute : Url.Url -> Route
parseRoute url =
  Maybe.withDefault NotFound (UP.parse routeParse url)


routeParse : Parser (Route -> a) a
routeParse =
  oneOf
    [ UP.map About (s "about")
    , UP.map About top
    , UP.map Contact (s "contact")
    , UP.map Resume (s "resume")
    , UP.map Projects (s "projects")
    , UP.map Project (s "project" </> string)
    ]

routeToString : Route -> String
routeToString route =
  case route of
    About -> "About"
    Contact -> "Contact"
    Resume -> "Resume"
    Projects -> "Projects"
    Project str -> "Project (" ++ str ++ ")"
    NotFound -> "Page Not Found"

getPage : Route -> Element msg
getPage route = 
  case route of
    About -> About.pageContent
    Resume -> Resume.pageContent
    Contact -> Contact.pageContent
    Projects -> Projects.pageContent
    Project p -> Projects.getProjectPage p
    _ -> el [] (text (routeToString route))