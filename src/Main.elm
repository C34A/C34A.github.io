module Main exposing (..)

import Element exposing (..)
import Element.Background as Background
import Browser
import Browser.Dom
import Browser.Dom exposing (Viewport)
import Browser.Navigation exposing (load)
import Task

import Url
import Browser.Navigation as Nav

import Boilerplate as Bp
import Pages

main = 
  Browser.application
    { init = init
    , update = update
    , view = view
    , subscriptions = subscriptions
    , onUrlChange = UrlChanged
    , onUrlRequest = LinkClicked
    }

type alias Model = 
  { vp : Maybe Viewport
  , key : Nav.Key
  , url : Url.Url
  , page: Pages.Route
  }

init :  () -> Url.Url -> Nav.Key -> (Model, Cmd Msg)
init flags url key 
  = 
    ( Model Nothing key url Pages.About
    , Task.perform GotViewport Browser.Dom.getViewport
    )

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

type Msg 
  = GotViewport Viewport
  | LinkClicked Browser.UrlRequest
  | UrlChanged Url.Url

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    GotViewport vp ->
      ({model | vp = Just vp}, Cmd.none)
    UrlChanged url ->
      ( { model 
          | url = url
          , page = Pages.parseRoute url}
      , if url.path == "/portfolio/portfolio" then load (url.path ++ ".html") else Cmd.none
      )
    LinkClicked urlRequest ->
      case urlRequest of
        Browser.Internal url ->
          ( model, Nav.pushUrl model.key (Url.toString url) )
        Browser.External href ->
          ( model, Nav.load href )

view : Model -> Browser.Document Msg
view model =
  { title = "C34A"
  , body = 
      [ layout [] (
          case model.vp of
            Nothing -> el [width fill, height fill, Background.color (rgb 0.1 0.1 0.12)] (text "")
            Just vp ->
              Bp.boilerplate vp (
                  column [ width fill, centerX]
                    [ Pages.getPage model.page
                    ]
              )
        )
      ]
  }