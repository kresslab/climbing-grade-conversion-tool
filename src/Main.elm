module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Debug exposing (log)
import Html exposing (Html, div, h1, i, option, p, select, text)
import Html.Attributes exposing (class, selected, value)
import Html.Events exposing (onInput)
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
    [ { french = "1", uiaa = "1", yds = "5", skill = "Novice" }
    , { french = "2", uiaa = "2", yds = "5.1/5.2", skill = "Novice" }
    , { french = "3", uiaa = "3", yds = "5.3/5.4", skill = "Novice" }
    , { french = "4a", uiaa = "4", yds = "5.5", skill = "Beginner" }
    , { french = "4b", uiaa = "4++", yds = "5.6", skill = "Beginner" }
    , { french = "4c", uiaa = "5", yds = "5.7", skill = "Beginner" }
    , { french = "5a", uiaa = "5+", yds = "5.8", skill = "Beginner" }
    , { french = "5b", uiaa = "6-", yds = "5.9", skill = "Intermediate" }
    , { french = "5c", uiaa = "6", yds = "5.10a", skill = "Intermediate" }
    , { french = "6a", uiaa = "6+", yds = "5.10b", skill = "Intermediate" }
    , { french = "6a+", uiaa = "7-", yds = "5.10c", skill = "Intermediate" }
    , { french = "6b", uiaa = "7", yds = "5.10d", skill = "Intermediate" }
    , { french = "6b+", uiaa = "7+", yds = "5.11a", skill = "Advanced" }
    , { french = "6c", uiaa = "8-", yds = "5.11b", skill = "Advanced" }
    , { french = "6c+", uiaa = "8", yds = "5.11c", skill = "Advanced" }
    , { french = "7a", uiaa = "8+", yds = "5.11d", skill = "Advanced" }
    , { french = "7a+", uiaa = "9-", yds = "5.12a", skill = "Advanced" }
    , { french = "7b", uiaa = "9-/9", yds = "5.12b", skill = "Expert" }
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
    { currentGrade : Int
    }


init : ( Model, Cmd Msg )
init =
    ( { currentGrade = 2 }, Cmd.none )



---- UPDATE ----


type Msg
    = SetCurrentGrade Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetCurrentGrade i ->
            ( { model | currentGrade = i }, Cmd.none )



--onChange : (String -> msg) -> Attribute msg
--onChange handler =
--on "change" <| Json.map handler <| Json.at [ "target", "value" ] Json.string
--[ onChange (\s -> SetCurrentGrade (Maybe.withDefault 0 (String.toInt s)))
--( model, Cmd.none )
--[ on "change" (Json.at [ "target", "value" ] Json.string) handleSetCurrentGrade
---- VIEW ----


handleSetCurrentGrade : String -> Msg
handleSetCurrentGrade s =
    SetCurrentGrade (Maybe.withDefault 0 (String.toInt s))


viewDropdown : String -> List String -> Model -> Html Msg
viewDropdown title os model =
    div []
        [ p [] [ text title ]
        , select [ onInput handleSetCurrentGrade ]
            (List.indexedMap
                (\i o ->
                    option
                        [ selected (i == model.currentGrade)
                        , value (String.fromInt i)
                        ]
                        [ text o ]
                )
                os
            )
        ]


viewDropDowns : Model -> Html Msg
viewDropDowns model =
    div []
        [ viewDropdown "French" (singleGrade French) model
        , viewDropdown "UIAA" (singleGrade UIAA) model
        , viewDropdown "YDS" (singleGrade YDS) model
        , viewDropdown "Basic Skill" (singleGrade Skill) model
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
        , viewDropDowns model
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
