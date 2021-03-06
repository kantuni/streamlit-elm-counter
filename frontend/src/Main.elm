port module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)



-- PORTS


port fromJS : (Int -> msg) -> Sub msg


port fromElm : Int -> Cmd msg



-- MODEL


type alias Model =
    { count : Int
    }



-- INIT


init : () -> ( Model, Cmd Msg )
init _ =
    ( { count = 0 }
    , Cmd.none
    )



-- UPDATE


type Msg
    = Default Int
    | Increment
    | Decrement


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Default value ->
            ( { model | count = value }
            , Cmd.none
            )

        Increment ->
            ( { model | count = model.count + 1 }
            , fromElm (model.count + 1)
            )

        Decrement ->
            ( { model | count = model.count - 1 }
            , fromElm (model.count - 1)
            )



-- VIEW


view : Model -> Html.Html Msg
view model =
    div [ style "display" "flex", style "gap" "8px" ]
        [ button [ onClick Decrement, class "button is-white" ] [ text "-" ]
        , span [ class "tag is-large is-link" ] [ text (String.fromInt model.count) ]
        , button [ onClick Increment, class "button is-white" ] [ text "+" ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    fromJS Default



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
