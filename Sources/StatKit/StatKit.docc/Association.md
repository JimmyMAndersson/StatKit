# Association

Measures of association help determine if and how two variables are related to each other.

## Overview

Association measures quantify the strength and direction of a relationship between two variables. The appropriate measure depends on the nature of the data: some measures assume a linear relationship on continuous data, while others are rank-based and apply to ordinal data. Rank-based measures differ in how they handle tied observations, which is an important consideration when ties are present in the data.

## Topics

### Functions

- ``StatKit/Swift/Collection/pearsonR(of:and:)``
- ``StatKit/Swift/Collection/spearmanR(of:and:)``
- ``StatKit/Swift/Collection/kendallTau(of:and:variant:)``
- ``StatKit/Swift/Collection/goodmanKruskalGamma(of:and:)``

### Enums

- ``KendallTauVariant``
