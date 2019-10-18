module Main exposing (Model, init, main, update, view)

--import Html.Extra as Html

import Browser
import Html exposing (Html, div, h1, i, option, p, select, text)
import Html.Attributes exposing (class, selected, value)
import Html.Events exposing (onClick, onInput)
import List exposing (map)
import Messages exposing (..)
import OverlayContent
import Svg exposing (path, svg)
import Svg.Attributes exposing (d, fill, height, viewBox, width)



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
    , { french = "4b", uiaa = "4+", yds = "5.6", skill = "Beginner" }
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


type alias MaybeContent =
    Maybe OverlayContent.Content


type alias Model =
    { currentGrade : Int
    , currentOverlay : ContentKind
    }


init : ( Model, Cmd Msg )
init =
    ( { currentGrade = 8
      , currentOverlay = None
      }
    , Cmd.none
    )



---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetCurrentGrade i ->
            ( { model | currentGrade = i }, Cmd.none )

        SetCurrentOverlay o ->
            ( { model | currentOverlay = o }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )



---- VIEW ----


viewDownArrowSvg : Html Msg
viewDownArrowSvg =
    svg [ Svg.Attributes.class "down-arrow", width "29", height " 20", viewBox "0 0 29 20", fill "none" ]
        [ path
            [ d "M18.0791 18.3311C16.1169 20.3425 12.8831 20.3425 10.9209 18.3311L1.566 8.74146C-1.52375 5.57419 0.720343 0.25 5.14506 0.250001L23.855 0.250002C28.2797 0.250003 30.5238 5.57419 27.434 8.74146L18.0791 18.3311Z"
            , fill "#4E4B5C"
            ]
            []
        ]


handleSetCurrentGrade : String -> Msg
handleSetCurrentGrade s =
    SetCurrentGrade (Maybe.withDefault 0 (String.toInt s))


handleLabelClick : GradeClassification -> Msg
handleLabelClick classification =
    case classification of
        YDS ->
            SetCurrentOverlay YDSWiki

        UIAA ->
            SetCurrentOverlay UIAAWiki

        French ->
            SetCurrentOverlay FrenchWiki

        Skill ->
            SetCurrentOverlay SkillBlurb


labelText : GradeClassification -> String
labelText classification =
    case classification of
        YDS ->
            "YDS"

        French ->
            "French"

        UIAA ->
            "UIAA"

        Skill ->
            "Basic Skill"


viewDropdown : GradeClassification -> List String -> Model -> Html Msg
viewDropdown classification os model =
    div [ class "dropdown" ]
        [ p [ onClick (handleLabelClick classification), class "dropdown__label" ]
            [ text
                (labelText
                    classification
                )
            ]
        , div [ class "select__wrapper" ]
            [ select [ onInput handleSetCurrentGrade ]
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
            , viewDownArrowSvg
            ]
        ]


viewDropDowns : Model -> Html Msg
viewDropDowns model =
    div [ class "dropdowns" ]
        [ viewDropdown French (singleGrade French) model
        , viewDropdown UIAA (singleGrade UIAA) model
        , viewDropdown YDS (singleGrade YDS) model
        , viewDropdown Skill (singleGrade Skill) model
        ]


viewHeader : Html Msg
viewHeader =
    div [ class "header" ]
        [ h1 [ class "title" ] [ text """Climbing
Grade
Conversion
Tool
""" ]
        , i [ onClick (SetCurrentOverlay Info), class "icon-info" ] []
        ]


viewOverlays : Model -> Html Msg
viewOverlays model =
    case model.currentOverlay of
        Info ->
            viewOverlay OverlayContent.contentInfo

        YDSWiki ->
            viewOverlay OverlayContent.contentYDS

        UIAAWiki ->
            viewOverlay OverlayContent.contentUIAA

        FrenchWiki ->
            viewOverlay OverlayContent.contentFrench

        SkillBlurb ->
            viewOverlay OverlayContent.contentSkill

        None ->
            div [] [ text "" ]


viewOverlay : OverlayContent.Content -> Html Msg
viewOverlay content =
    div [ class "overlay__bg" ]
        [ div [ class "overlay" ]
            [ div [ class "overlay__title-wrapper" ] [ h1 [ class "overlay__title" ] [ text content.title ] ]
            , div [ class "overlay__close-btn", onClick (SetCurrentOverlay None) ] [ i [ class "icon-close" ] [] ]
            , div [ class "overlay__content" ] [ content.body ]
            ]
        ]


view : Model -> Html Msg
view model =
    div []
        [ viewHeader
        , viewDropDowns model
        , viewOverlays model
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
