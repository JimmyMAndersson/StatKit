# Ranking

Put rankings on data points such that, for any two items, they are either ranked higher, lower, or equal to each other.

## Overview

There are several ways of ranking items. The most common ones are implemented as a `RankingStrategy`, allowing for immediate use. The strategies differ in how they handle tied observations, so choose the one that matches the convention expected by your analysis.

## Topics

### Functions

- ``StatKit/Swift/Collection/rank(variable:by:strategy:)``

### Strategies

- ``RankingStrategy``
