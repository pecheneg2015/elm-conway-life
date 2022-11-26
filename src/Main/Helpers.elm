module Main.Helpers exposing (boolListGenerator, boolToInt)

import Random


boolGenerator : Random.Generator Bool
boolGenerator =
    Random.weighted ( 30, True ) [ ( 70, False ) ]


boolListGenerator : Int -> Random.Generator (List Bool)
boolListGenerator len =
    Random.list len boolGenerator


boolToInt : Bool -> Int
boolToInt val =
    case val of
        True ->
            1

        False ->
            0
