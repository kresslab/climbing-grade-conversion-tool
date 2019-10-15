module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, div, h1, i, option, p, select, text)
import Html.Attributes exposing (class)
import List exposing (map)



---- MODEL ----


type GradeClassification
    = French
    | UIAA
    | YDS
    | Skill


type alias Grade =
    { french : String
    , uiaa : String
    , yds : String
    , skill : String
    }


grades : List Grade
grades =
    [ { french = "1"
      , uiaa = "1"
      , yds = "5"
      , skill = "Novice"
      }
    , { french = "2"
      , uiaa = "2"
      , yds = "5.1/5.2"
      , skill = "Novice"
      }
    ]


singleGrade : GradeClassification -> List String
singleGrade g =
    case g of
        French ->
            map (\gr -> gr.french) grades

        UIAA ->
            map (\gr -> gr.uiaa) grades

        YDS ->
            map (\gr -> gr.yds) grades

        Skill ->
            map (\gr -> gr.skill) grades


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


viewDropdown : String -> List String -> Html Msg
viewDropdown title os =
    div []
        [ p [] [ text title ]
        , select []
            (map (\o -> option [] [ text o ]) os)
        ]


viewDropDowns : Html Msg
viewDropDowns =
    div []
        [ viewDropdown "French" (singleGrade French)
        , viewDropdown "UIAA" (singleGrade UIAA)
        , viewDropdown "YDS" (singleGrade YDS)
        ]


viewHeader : Html Msg
viewHeader =
    div [ class "header" ]
        [ h1 [ class "title" ] [ text """Climbing 
Grade
Conversion
Tool
""" ]
        , i [ class "icon-info" ] []
        ]


view : Model -> Html Msg
view model =
    div []
        [ viewHeader
        , viewDropDowns
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
