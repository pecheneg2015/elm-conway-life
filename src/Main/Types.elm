module Main.Types exposing (Model, Msg(..))

import Array exposing (Array)


type Msg
    = ToggleCellValue Int
    | ToggleIsStarted
    | CalculateFieldValue
    | SpeedUp
    | SpeedDown
    | GenerateField
    | SetField (List Bool)


type alias Model =
    { isStarted : Bool
    , cellArray : Array Bool
    , width : Int
    , fieldLen : Int
    , height : Int
    , speed : Float
    }
