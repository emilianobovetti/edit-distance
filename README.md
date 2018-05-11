# Edit Distance

Elm package to compute edit distance.

Currently only [Levenshtein distance](https://en.wikipedia.org/wiki/Levenshtein_distance) is supported with `O(mn)` time complexity.

This means that could take a while with long strings in input, so please run some tests.

```elm
levenshteinOfStrings "kitten" "sitten" == 1
-- substitution of "s" for "k"

levenshteinOfStrings "sittin" "sitting" == 1
-- insertion of "g" at the end
```
