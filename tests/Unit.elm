module Unit exposing (unit)

import EditDistance exposing (levenshtein, levenshteinOfStrings)
import Expect exposing (Expectation)
import Test exposing (..)


unit : Test
unit =
    describe "EditDistance"
        [ describe "#levenshtein"
            [ test "should be 0 on empty lists" <|
                \_ -> Expect.equal 0 (levenshtein [] [])
            , test "should be 0 on [0] [0]" <|
                \_ -> Expect.equal 0 (levenshtein [ 0 ] [ 0 ])
            , test "should be 1 on [] [0]" <|
                \_ -> Expect.equal 1 (levenshtein [] [ 0 ])
            , test "should be 1 on [0] []" <|
                \_ -> Expect.equal 1 (levenshtein [ 0 ] [])
            , test "should be 1 on [0] [1]" <|
                \_ -> Expect.equal 1 (levenshtein [ 0 ] [ 1 ])
            , test "should be 1 on [1] [0]" <|
                \_ -> Expect.equal 1 (levenshtein [ 1 ] [ 0 ])
            ]
        , describe "#levenshteinOfStrings"
            [ test "should be 0 on empty strings" <|
                \_ -> Expect.equal 0 (levenshteinOfStrings "" "")
            , test "should be 1 on 'kitten' 'sitten'" <|
                \_ -> Expect.equal 1 (levenshteinOfStrings "kitten" "sitten")
            , test "should be 1 on 'sittin' 'sitting'" <|
                \_ -> Expect.equal 1 (levenshteinOfStrings "sittin" "sitting")
            , test "should work with surrogate pairs" <|
                \_ -> Expect.equal 1 (levenshteinOfStrings "x" "🚀")
            ]
        ]
