module EditDistance exposing (levenshtein, levenshteinOfStrings)

{-| Algorithms for edit distance calculation.


# Levenshtein distance

@docs levenshtein, levenshteinOfStrings

-}

import Bitwise


min3 : Int -> Int -> Int -> Int
min3 a b c =
    let
        diff1 : Int
        diff1 =
            a - b

        minAB : Int
        minAB =
            b + Bitwise.and diff1 (Bitwise.shiftRightBy 31 diff1)

        diff2 : Int
        diff2 =
            minAB - c
    in
    c + Bitwise.and diff2 (Bitwise.shiftRightBy 31 diff2)


patternLoop : comparable -> List comparable -> Int -> Int -> Int -> List Int -> List Int
patternLoop textHead pattern b0 b1 b2 prev =
    case pattern of
        patternHead :: patternTail ->
            case prev of
                prevHead :: prevTail ->
                    let
                        b0_ : Int
                        b0_ =
                            b1

                        b1_ : Int
                        b1_ =
                            prevHead

                        b2_ : Int
                        b2_ =
                            if textHead == patternHead then
                                b0

                            else
                                1 + min3 b0 b1 b2
                    in
                    b2_ :: patternLoop textHead patternTail b0_ b1_ b2_ prevTail

                [] ->
                    if textHead == patternHead then
                        [ b0 ]

                    else
                        [ 1 + min3 b0 b1 b2 ]

        [] ->
            []


initPatternLoop : comparable -> List comparable -> Int -> List Int -> List Int
initPatternLoop textHead pattern b0 prevCol =
    case prevCol of
        prevHead :: prevTail ->
            patternLoop textHead pattern b0 prevHead (b0 + 1) prevTail

        _ ->
            []


textLoop : List comparable -> List comparable -> Int -> List Int -> List Int
textLoop text pattern idx col =
    case text of
        [] ->
            col

        textHead :: textTail ->
            let
                nextCol : List Int
                nextCol =
                    initPatternLoop textHead pattern (idx - 1) col
            in
            textLoop textTail pattern (idx + 1) nextCol


last : List a -> Maybe a
last list =
    case list of
        [ value ] ->
            Just value

        _ :: tail ->
            last tail

        [] ->
            Nothing


{-| Finds the [Levenshtein distance](https://en.wikipedia.org/wiki/Levenshtein_distance)
between two `List comparable` in `O(mn)`.

    kitten = String.toList "kitten"
    sitten = String.toList "sitten"
    sittin = String.toList "sittin"
    sitting = String.toList "sitting"

    levenshtein kitten sitten == 1
    levenshtein sitten sittin == 1
    levenshtein sittin sitting == 1

-}
levenshtein : List comparable -> List comparable -> Int
levenshtein text pattern =
    case ( text, pattern ) of
        ( [], _ ) ->
            List.length pattern

        ( _, [] ) ->
            List.length text

        ( [ textHead ], _ ) ->
            if List.any ((==) textHead) pattern then
                List.length pattern - 1

            else
                List.length pattern

        ( _, [ patternHead ] ) ->
            if List.any ((==) patternHead) text then
                List.length text - 1

            else
                List.length text

        ( textHead :: textTail, patternHead :: patternTail ) ->
            if textHead == patternHead then
                levenshtein textTail patternTail

            else
                List.range 1 (List.length pattern)
                    |> textLoop text pattern 1
                    |> last
                    |> Maybe.withDefault -1


{-| Like [levenshtein](#levenshtein), but takes two `String` as input.
-}
levenshteinOfStrings : String -> String -> Int
levenshteinOfStrings text pattern =
    if text == pattern then
        0

    else if String.length pattern > String.length text then
        levenshtein (String.toList pattern) (String.toList text)

    else
        levenshtein (String.toList text) (String.toList pattern)
