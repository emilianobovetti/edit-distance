module Unit exposing (unit)

import EditDistance exposing (levenshtein, levenshteinOfStrings)
import Expect exposing (Expectation)
import Test exposing (..)


unit : Test
unit =
    describe "EditDistance"
        [ describe "#levenshtein"
            [ test "should be zero on empty lists" <|
                \_ -> Expect.equal 0 (levenshtein [] [])
            , test "should be zero on [0] [0]" <|
                \_ -> Expect.equal 0 (levenshtein [ 0 ] [ 0 ])
            , test "should be one on [] [0]" <|
                \_ -> Expect.equal 1 (levenshtein [] [ 0 ])
            , test "should be one on [0] []" <|
                \_ -> Expect.equal 1 (levenshtein [ 0 ] [])
            , test "should be one on [0] [1]" <|
                \_ -> Expect.equal 1 (levenshtein [ 0 ] [ 1 ])
            , test "should be one on [1] [0]" <|
                \_ -> Expect.equal 1 (levenshtein [ 1 ] [ 0 ])
            ]
        , describe "#levenshteinOfStrings"
            [ test "should be zero on empty strings" <|
                \_ -> Expect.equal 0 (levenshteinOfStrings "" "")
            , test "should be one on 'kitten' 'sitten'" <|
                \_ -> Expect.equal 1 (levenshteinOfStrings "kitten" "sitten")
            , test "should be one on 'sittin' 'sitting'" <|
                \_ -> Expect.equal 1 (levenshteinOfStrings "sittin" "sitting")
            ]
        ]
