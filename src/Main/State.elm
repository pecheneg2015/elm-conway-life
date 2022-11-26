module Main.State exposing (initData, update)

import Array exposing (Array)
import Main.Helpers exposing (boolListGenerator, boolToInt)
import Main.Types exposing (Model, Msg(..))
import Random


getInitValue : Int -> Int -> Model
getInitValue width height =
    { isStarted = False
    , speed = 1
    , width = width
    , height = height
    , fieldLen = width * height
    , cellArray = Array.initialize (width * height) (always False)
    }


initData : Int -> ( Model, Cmd Msg )
initData _ =
    ( getInitValue 25 25, Cmd.none )


toggleCell : Array Bool -> Int -> Array Bool
toggleCell field ind =
    let
        value =
            not <| Maybe.withDefault False <| Array.get ind field
    in
    Array.set ind value field


recalculateCellArray : Model -> Array Bool
recalculateCellArray model =
    let
        field =
            model.cellArray

        prepareCell =
            calculateCellValue model
    in
    Array.indexedMap (\x y -> prepareCell ( x, y )) field


getCellValue : Model -> Int -> ( Int, Int ) -> Int
getCellValue model ind deltaTuple =
    let
        ( lineDelta, indDelta ) =
            deltaTuple

        x =
            getIndLine model (ind + lineDelta)

        y =
            getInd model.width <| indDelta + ind
    in
    boolToInt <| getItemValue model x y


calculateCellValue : Model -> ( Int, Bool ) -> Bool
calculateCellValue model cellInfo =
    let
        ( ind, currentVal ) =
            cellInfo

        width =
            model.width

        neighboursDeltaList : List ( Int, Int )
        neighboursDeltaList =
            [ ( -width, -1 ), ( -width, 0 ), ( -width, 1 ), ( 0, -1 ), ( 0, 1 ), ( width, -1 ), ( width, 0 ), ( width, 1 ) ]

        getCellValuePartial =
            getCellValue model ind

        neighboursValSum =
            List.foldl (+) 0 <| List.map getCellValuePartial neighboursDeltaList
    in
    case currentVal of
        True ->
            getLiveCellNewVal neighboursValSum

        False ->
            getDeadCellNewVal neighboursValSum


getIndLine : Model -> Int -> Int
getIndLine { width, fieldLen } ind =
    let
        normInd =
            remainderBy fieldLen ind
    in
    if normInd >= 0 then
        normInd // width

    else
        (fieldLen - 1) // width


getInd : Int -> Int -> Int
getInd width ind =
    let
        line =
            ind // width

        firstLineInd =
            line * width

        lastLineInd =
            firstLineInd + width - 1
    in
    if ind < firstLineInd then
        remainderBy width lastLineInd

    else if ind > lastLineInd then
        remainderBy width firstLineInd

    else
        remainderBy width ind


getItemValue : Model -> Int -> Int -> Bool
getItemValue { width, cellArray } line ind =
    let
        arrInd =
            line * width + ind

        item =
            Array.get arrInd cellArray
    in
    Maybe.withDefault False item


getLiveCellNewVal : Int -> Bool
getLiveCellNewVal neighboursCount =
    case neighboursCount of
        2 ->
            True

        3 ->
            True

        _ ->
            False


getDeadCellNewVal : Int -> Bool
getDeadCellNewVal neighboursCount =
    case neighboursCount of
        3 ->
            True

        _ ->
            False


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GenerateField ->
            let
                { width, height } =
                    model

                fieldLen =
                    width * height
            in
            ( model, Random.generate SetField <| boolListGenerator fieldLen )

        SetField l ->
            ( { model | cellArray = Array.fromList l }, Cmd.none )

        ToggleIsStarted ->
            ( { model | isStarted = not model.isStarted }, Cmd.none )

        CalculateFieldValue ->
            ( { model | cellArray = recalculateCellArray model }, Cmd.none )

        SpeedUp ->
            ( { model | speed = model.speed / 2 }, Cmd.none )

        SpeedDown ->
            ( { model | speed = model.speed * 2 }, Cmd.none )

        ToggleCellValue ind ->
            ( { model | cellArray = toggleCell model.cellArray ind }, Cmd.none )
