public protocol MathematicalFunction {
  associatedtype Input
  associatedtype Output
}

public protocol FittableFunction: MathematicalFunction {
  func fit<S: Sequence, T: Sequence>(
    _ input: S,
    to output: T,
    using parameters: [KeyPath<Input, ConvertibleToReal>]
  )
  where S.Element == Input, T.Element == Output
}

public protocol PredictiveModel: MathematicalFunction {
  func predict(_ input: Input) -> Output
  
  func predict<S: Sequence>(_ input: S) -> [Output]
  where S.Element == Input
}

public extension PredictiveModel {
  func predict<S: Sequence>(_ input: S) -> [Output]
  where S.Element == Input {
    return input.map(predict)
  }
}
