module Main exposing (main)

import Browser
import Main.State exposing (initData, update)
import Main.Subscriptions exposing (subscriptions)
import Main.Types exposing (Model, Msg)
import Main.View exposing (view)


main : Program Int Model Msg
main =
    Browser.document
        { init = initData
        , update = update
        , view =
            \m ->
                { title = "ElmConwayLife"
                , body = [ view m ]
                }
        , subscriptions = subscriptions
        }
