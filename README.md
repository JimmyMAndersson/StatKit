<p align="center">
<img src="https://raw.githubusercontent.com/JimmyMAndersson/StatKit/master/StatKit%20Logo.png" width="500" max-width="90%" alt="StatKit" />
</p>

<p align="center">
    <img src="https://img.shields.io/badge/Swift-5.2-blue.svg" />
    <a href="https://swift.org/package-manager">
        <img src="https://img.shields.io/badge/swiftpm-compatible-orange.svg?style=flat" alt="Swift Package Manager" />
    </a>
     <img src="https://img.shields.io/badge/platforms-mac+linux-brightgreen.svg?style=flat" alt="macOS + iOS + iPadOS" />
    <a href="https://twitter.com/jimmymandersson">
        <img src="https://img.shields.io/badge/twitter-@jimmymandersson-blue.svg?style=flat" alt="Twitter: @jimmymandersson" />
    </a>
</p>

Welcome to **StatKit**, a collection of statistical analysis tools for Swift developers. StatKit adds tools for statistical analysis directly to the Swift types you use every day, such as Array, Set, and Dictionary. 

## Builtin Statistics

StatKit extends the Swift standard library to include relevant functionality for statistical analysis in the types you work with every day. Using StatKit, you will be able to calculate a variety of useful statistics such as:

* **Central Tendency**  
*Calculate modes, means, and medians of your data collections.*

* **Variability**  
*Compute variances and standard deviations.*

* **Correlation**  
*Find linear tendencies and covariance of measurements.* 

A simple example would be to calculate the modes of an integer array, which can be done easily with the following piece of code:

```swift
print([1, 2, 3, 3, 2, 4].mode(of: \.self))

// Prints [3, 2]
```

In this case, `mode(of:)` takes a KeyPath argument which specifies the variable inside the array that you are interested in. In the example above, we specify the `\.self` keypath, which points to the array element itself (in this case, the integers).

The pattern of specifying one or more variables to investigate is common throughout the StatKit library. It allows you to calculate similar statistics for a variety of different types using the same syntax. For example, both of the below examples produce valid results, even though the types under investigation are completely disparate:  

**Calculating the mode of all characters in a `String`:**  

```swift
print("StatKit".mode(of: \.self))

// Prints ["t"]
```  

**Calculating the mode of `CGPoint` y-values in an array:**  

```swift
import CoreGraphics

let points = [CGPoint(x: 0, y: 1), 
              CGPoint(x: 1, y: 3), 
              CGPoint(x: 3, y: 1)]

print(points.mode(of: \.y))
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

measurements.mean(.arithmetic, of: \.litersPer10Km)
measurements.standardDeviation(of: \.litersPer10Km, from: .sample)
```

As you can see, using KeyPath's makes the StatKit API easy to use and reusable across completely arbitrary custom structures. This example also exposes two other recuring patterns.

## Specifying calculation methods and bias functions

Firstly, the possibility to pick between different calculation methods that is seen in the `mean(_:of:)` method. Since there are often multiple methods of calculating the same type of statistic, StatKit provides parameters for you to choose which method you would like to use. If deemed a better fit for the problem at hand, the `.arithmetic` argument could be exchanged for `.geometric`. This change, rather obviously, results in computation of the geometric mean, instead of the arithmetic mean.

Secondly, the possibility of specifying whether your data constitues an entire population or whether it should be considered a sample. Since many estimators use different techniques to reduce the bias of their results, you are able to provide the library with important hints about the data sets composition to get better calculations. In the fuel consumption example, the `standardDeviation(of:from:)` method gives you the opportunity to specify whether your measurements consitute the entire population, or merely a sample of the population that is under investigation.

## System Requirements
To use StatKit, make sure that your system has Swift 5.2 (or later) installed. If you’re using a Mac, also make sure that `xcode-select` points at an Xcode installation that includes a valid version of Swift and that you’re running macOS Catalina (10.15) or later.

**IMPORTANT**  
StatKit **does not** officially support any beta software, including beta versions of Xcode and macOS, or unreleased versions of Swift.

## Installation
### Swift Package Manager

To install StatKit using the [Swift Package Manager](https://swift.org/package-manager), add it as a dependency in your `Package.swift` file:

```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/JimmyMAndersson/StatKit.git", from: "0.1.0")
    ],
    ...
)
```

Then import StatKit where you would like to use it:

```swift
import StatKit
```
### Cocoapods

To install StatKit using [Cocoapods](https://cocoapods.org/), simply add `pod 'StatKit'` to your Podfile. To use a specific version, check out the [Podfile reference](https://guides.cocoapods.org/using/the-podfile.html) for the appropriate syntax.

```ruby
target 'MyApp' do
  use_frameworks!
  pod 'StatKit'
end
```

## Contributions and support

StatKit is a young project that is under active development, and is likely to have limitations. These limitations are most likely to be discovered and uncovered as more people starts using it, since use cases may vary greatly between developers.

If you would like to see some missing feature in the library, feel free to open an issue and open a Pull Request. Every Pull Request - from documentation additions to advanced computational functionality - is welcome.

Enjoy using **StatKit**!
