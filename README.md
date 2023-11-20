<p align="center">
    <img src="https://raw.githubusercontent.com/JimmyMAndersson/StatKit/master/StatKit%20Logo.png" width="500" max-width="90%" alt="StatKit" />
</p>

***
<p align="center">
    <img src="https://img.shields.io/github/actions/workflow/status/JimmyMAndersson/StatKit/TestSuite.yml?label=test%20suite&branch=master" />
    <img src="https://img.shields.io/github/actions/workflow/status/JimmyMAndersson/StatKit/CodeStyle.yml?label=code%20style&branch=master" />
    <img src="https://img.shields.io/badge/platforms-mac+linux-brightgreen.svg?style=flat" alt="Platform Support" />
</p>

<p align="center">
    <a href="https://www.linkedin.com/in/jmandersson/">
        <img src="https://img.shields.io/badge/linkedin-jimmy%20m%20andersson-blue.svg?style=flat" alt="LinkedIn: Jimmy M Andersson" />
    </a>
    <a href="https://github.com/sponsors/JimmyMAndersson">
        <img src="https://img.shields.io/badge/%E2%9D%A4-sponsor this project-blue.svg?style=flat" alt="Sponsor this project" />
    </a>
</p>

<p align="center">
    <img src="https://img.shields.io/badge/swift-5.7-blueviolet.svg" />
    <img src="https://img.shields.io/badge/swift pm-compatible-blueviolet.svg?style=flat" alt="Swift PM Compatible" />
</p>

***

Welcome to **StatKit**, a collection of statistical analysis tools for Swift developers.

## Builtin Statistics

StatKit adds relevant functionality for statistical analysis for the types you use every day. With StatKit, you will be able to calculate a variety of useful statistics such as:

* **Central Tendency**  
*Calculate modes, means, and medians of your data sets.*

* **Variability**  
*Compute variances and standard deviations.*

* **Correlation**  
*Find linear tendencies and covariance of measurements.* 

* **Distributions**  
*Make computations using several common distribution types.* 

A simple example would be to calculate the modes of an integer array, which can be done easily with the following piece of code:

```swift
print([1, 2, 3, 3, 2, 4].mode(variable: \.self))

// Prints [3, 2]
```

In this case, `Collection.mode(variable:)` takes a KeyPath argument which specifies the variable inside the array that you are interested in. In the example above, we specify the `\.self` keypath, which points to the array element itself (in this case, the integers).

The pattern of specifying one or more variables to investigate is common throughout the StatKit library. It allows you to calculate similar statistics for a variety of different types using the same syntax. For example, both of the below examples produce valid results, even though the types under investigation are completely disparate:  

**Calculating the mode of all characters in a `String`:**  

```swift
print("StatKit".mode(variable: \.self))

// Prints ["t"]
```  

**Calculating the mode of `CGPoint` y-values in an array:**  

```swift
import CoreGraphics

let points = [CGPoint(x: 0, y: 1), 
              CGPoint(x: 1, y: 3), 
              CGPoint(x: 3, y: 1)]

print(points.mode(variable: \.y))
// Prints [1.0]
```

## Computing statistics for collections of complex custom types

As the examples in the previous section showed, calculating statistics is easy when using collections of types that are readily available. However, most of us work with custom data structures in our projects. Luckily, StatKit provides support for arbitrary custom types thanks to the extensive use of generics.

Let us look at a custom data structure that keeps track of collected data points for a specific brand of cars, and how we can use StatKit to wasily calculate the mean and standard deviation of their fuel consumption:

```swift
struct FuelConsumption {
  let modelYear: String
  let litersPer10Km: Double
}

let measurements: [FuelConsumption] = [...]

measurements.mean(variable: \.litersPer10Km, strategy: .arithmetic)
measurements.standardDeviation(variable: \.litersPer10Km, from: .sample)
```

As you can see, using KeyPath's makes the StatKit API easy to use and reusable across completely arbitrary custom structures.

## Distributions

StatKit provides multiple discrete and continuous distribution types for you to work with. These allow you to compute probabilities, calculate common moments such as the skewness and kurtosis, and sample random numbers from a specific data distribution.

```swift
let normal = NormalDistribution(mean: 0, variance: 1)
print(normal.cdf(x: 0))
// Prints 0.5

let normalRandomVariables = normal.sample(10)
// Generates 10 samples from the normal distribution
```

## Documentation
StatKit is documented using Swift-DocC, which means that the documentation pages can be built by Xcode and viewed in the Developer Documentation panel. Build it by clicking `Product > Build Documentation` or hitting `Shift + Ctrl + Cmd + D`.

## System Requirements
To use StatKit, make sure that your system has Swift 5.7 (or later) installed. If you’re using a Mac, also make sure that `xcode-select` points at an Xcode installation that includes a valid version of Swift and that you’re running macOS Monterey (12.5) or later.

**IMPORTANT**  
StatKit **does not** officially support any beta software, including beta versions of Xcode and macOS, or unreleased versions of Swift.

## Installation
### Swift Package Manager

To install StatKit using the [Swift Package Manager](https://swift.org/package-manager), add it as a dependency in your `Package.swift` file:

```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/JimmyMAndersson/StatKit.git", from: "0.6.0")
    ],
    ...
)
```

Then import StatKit where you would like to use it:

```swift
import StatKit
```

## Contributions and support

StatKit is a young project that is under active development. Our vision is to create the go-to statistics library for Swift developers, much like SciPy and NumPy are for the Python language.

[:heart: Consider becoming a sponsor](https://github.com/sponsors/JimmyMAndersson) to support the development of this library.\
You could cover an afternoon coffee or a meal to keep my neurons firing.

Thank you for your contribution, and enjoy using **StatKit**!
