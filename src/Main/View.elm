module Main.View exposing (view)

import Array exposing (Array)
import Html exposing (Html, button, div, p, text)
import Html.Attributes exposing (attribute, class, disabled)
import Html.Events exposing (onClick)
import Html.Lazy exposing (lazy2)
import Main.Types exposing (Model, Msg(..))


getCellCLassList : Bool -> String
getCellCLassList val =
    case val of
        True ->
            "cell cell__active"

        False ->
            "cell cell__inactive"


renderCell : Bool -> Int -> Bool -> Html Msg
renderCell isStarted ind val =
    let
        classlist =
            getCellCLassList val

        ariaLabelText =
            "cell" ++ String.fromInt ind
    in
    button [ class classlist, disabled isStarted, onClick (ToggleCellValue ind), attribute "aria-label" ariaLabelText ] [ text "" ]


renderCellArray : Bool -> Array Bool -> List (Html Msg)
renderCellArray isStarted arr =
    let
        renderCellPartial =
            lazy2 (renderCell isStarted)
    in
    Array.toList <| Array.indexedMap renderCellPartial arr


getButtonText : Bool -> String
getButtonText isActive =
    if isActive then
        "End"

    else
        "Start"


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ div [ class "content" ]
            [ p [ class "title" ] [ text "Conway's Game of Life" ]
            , div [ class "button-group" ]
                [ button [ onClick ToggleIsStarted, class "button-group__button__small button-group__button" ] [ text <| getButtonText model.isStarted ]
                , button [ onClick GenerateField, class "button-group__button__large button-group__button", disabled <| model.isStarted ] [ text "Generate field" ]
                , button [ onClick SpeedDown, class "button-group__button__medium button-group__button", disabled <| model.speed >= 4 ] [ text "Speed down" ]
                , button [ onClick SpeedUp, class "button-group__button__medium button-group__button", disabled <| model.speed <= 0.25 ] [ text "Speed up" ]
                ]
            , div [ class "field field__25" ] (renderCellArray model.isStarted model.cellArray)
            ]
        ]
