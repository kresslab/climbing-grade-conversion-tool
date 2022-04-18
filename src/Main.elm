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
    | EBS


type alias Grade =
    { french : String
    , uiaa : String
    , yds : String
    , ewbank : String
    }


grades : List Grade
grades =
    [ { french = "1", uiaa = "1", yds = "5", ewbank = "4" }
    , { french = "2", uiaa = "2", yds = "5.1/5.2", ewbank = "5" }
    , { french = "3", uiaa = "3", yds = "5.3/5.4", ewbank = "9" }
    , { french = "4a", uiaa = "4", yds = "5.5", ewbank = "12" }
    , { french = "4b", uiaa = "4+", yds = "5.6", ewbank = "14" }
    , { french = "4c", uiaa = "5", yds = "5.7", ewbank = "15" }
    , { french = "5a", uiaa = "5+", yds = "5.8", ewbank = "16" }
    , { french = "5b", uiaa = "6-", yds = "5.9", ewbank = "17" }
    , { french = "5c", uiaa = "6", yds = "5.10a", ewbank = "18" }
    , { french = "6a", uiaa = "6+", yds = "5.10b", ewbank = "19" }
    , { french = "6a+", uiaa = "7-", yds = "5.10c", ewbank = "20" }
    , { french = "6b", uiaa = "7", yds = "5.10d", ewbank = "21" }
    , { french = "6b+", uiaa = "7+", yds = "5.11a", ewbank = "22" }
    , { french = "6c", uiaa = "8-", yds = "5.11b", ewbank = "23" }
    , { french = "6c+", uiaa = "8", yds = "5.11c", ewbank = "23/24" }
    , { french = "7a", uiaa = "8+", yds = "5.11d", ewbank = "24" }
    , { french = "7a+", uiaa = "8+/9-", yds = "5.12a", ewbank = "25" }
    , { french = "7b", uiaa = "9-", yds = "5.12b", ewbank = "26" }
    , { french = "7b+", uiaa = "9-/9", yds = "5.12c", ewbank = "27" }
    , { french = "7c", uiaa = "9", yds = "5.12d", ewbank = "28" }
    , { french = "7c+", uiaa = "9+", yds = "5.13a", ewbank = "29" }
    , { french = "8a", uiaa = "9+/10-", yds = "5.13b", ewbank = "30" }
    , { french = "8a+", uiaa = "10-/10", yds = "5.13c", ewbank = "31" }
    , { french = "8b", uiaa = "10/10+", yds = "5.13d", ewbank = "32" }
    , { french = "8b+", uiaa = "10+", yds = "5.14a", ewbank = "33" }
    , { french = "8c", uiaa = "11-", yds = "5.14b", ewbank = "34" }
    , { french = "8c+", uiaa = "11-/11", yds = "5.14c", ewbank = "35" }
    , { french = "9a", uiaa = "11/11+", yds = "5.14d", ewbank = "36" }
    , { french = "9a+", uiaa = "11+", yds = "5.15a", ewbank = "37" }
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

        EBS ->
            map (\gr -> gr.ewbank) grades


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

        EBS ->
            SetCurrentOverlay EwbankWiki


labelText : GradeClassification -> String
labelText classification =
    case classification of
        YDS ->
            "YDS"

        French ->
            "French"

        UIAA ->
            "UIAA"

        EBS ->
            "EBS"


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
        , viewDropdown EBS (singleGrade EBS) model
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

        EwbankWiki ->
            viewOverlay OverlayContent.contentAus

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
