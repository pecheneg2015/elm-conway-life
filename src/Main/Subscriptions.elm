module Main.Subscriptions exposing (subscriptions)

import Main.Types exposing (Model, Msg(..))
import Time


subscriptions : Model -> Sub Msg
subscriptions model =
    if model.isStarted then
        Time.every (model.speed * 200) (always CalculateFieldValue)

    else
        Sub.none
