import Testing
import StatKit

@Suite("Ranking Tests", .tags(.ranking))
struct RankingTests {
  private typealias RankingInput<T> = [([T], (T, T) -> Bool, [Double], RankingStrategy)]

  @Test(
    "Valid integer data sets produce valid rankings",
    arguments: [
      ([1, 2, 3, 4, 5], >, [5, 4, 3, 2, 1], .dense),
      ([1, 3, 4, 3, 5], >, [4, 3, 2, 3, 1], .dense),
      ([1, 2, 3, 4, 5], <, [1, 2, 3, 4, 5], .dense),
      ([1, 3, 4, 3, 5], <, [1, 2, 3, 2, 4], .dense),
      ([], <, [], .dense),
      ([1], <, [1], .dense),
      ([1, 3, 5, 3], <=, [1, 2, 3, 2], .dense),

      ([1, 3, 4, 2, 5], >, [5, 3, 2, 4, 1], .fractional),
      ([1, 3, 4, 3, 5], >, [5, 3.5, 2, 3.5, 1], .fractional),
      ([1, 3, 4, 2, 5], <, [1, 3, 4, 2, 5], .fractional),
      ([1, 3, 4, 3, 5], <, [1, 2.5, 4, 2.5, 5], .fractional),
      ([], <, [], .fractional),
      ([1], <, [1], .fractional),
      ([1, 3, 5, 3], <=, [1, 2.5, 4, 2.5], .fractional),

      ([1, 3, 4, 2, 5], >, [5, 3, 2, 4, 1], .modifiedCompetition),
      ([1, 3, 4, 3, 5], >, [5, 4, 2, 4, 1], .modifiedCompetition),
      ([1, 3, 4, 2, 5], <, [1, 3, 4, 2, 5], .modifiedCompetition),
      ([1, 3, 4, 3, 5, 3, 3], <, [1, 5, 6, 5, 7, 5, 5], .modifiedCompetition),
      ([], <, [], .modifiedCompetition),
      ([1], <, [1], .modifiedCompetition),
      ([1, 3, 5, 3], <=, [1, 3, 4, 3], .modifiedCompetition),

      ([1, 3, 4, 2, 5], >, [5, 3, 2, 4, 1], .standardCompetition),
      ([1, 3, 4, 3, 5], >, [5, 3, 2, 3, 1], .standardCompetition),
      ([1, 3, 4, 2, 5], <, [1, 3, 4, 2, 5], .standardCompetition),
      ([1, 3, 4, 3, 5, 3, 3], <, [1, 2, 6, 2, 7, 2, 2], .standardCompetition),
      ([], <, [], .standardCompetition),
      ([1], <, [1], .standardCompetition),
      ([1, 3, 5, 3], <=, [1, 2, 4, 2], .standardCompetition),

      ([1, 3, 4, 2, 5], >, [5, 3, 2, 4, 1], .ordinal),
      ([1, 3, 4, 3, 5], >, [5, 3, 2, 4, 1], .ordinal),
      ([1, 3, 4, 2, 5], <, [1, 3, 4, 2, 5], .ordinal),
      ([1, 3, 4, 3, 5, 3, 3], <, [1, 2, 6, 3, 7, 4, 5], .ordinal),
      ([], <, [], .ordinal),
      ([1], <, [1], .ordinal),
      ([1, 3, 5, 3], <=, [1, 2, 4, 3], .ordinal),
    ] as RankingInput<Int>
  )
  func validIntegerDataSets(
    data: [Int],
    ordering: @escaping (Int, Int) -> Bool,
    expectedRank: [Double],
    strategy: RankingStrategy
  ) async {
    #expect(data.rank(variable: \.self, by: ordering, strategy: strategy) == expectedRank)
  }

  @Test(
    "Valid floating point data sets produce valid rankings",
    arguments: [
      ([.infinity, .pi, -.infinity, -.pi], <, [4, 3, 1, 2], .dense),
      ([-.infinity, -.infinity, .infinity, .infinity], <, [1, 1, 2, 2], .dense),

      ([.infinity, .pi, -.infinity, -.pi], <, [4, 3, 1, 2], .fractional),
      ([-.infinity, -.infinity, .infinity, .infinity], <, [1.5, 1.5, 3.5, 3.5], .fractional),

      ([.infinity, .pi, -.infinity, -.pi], <, [4, 3, 1, 2], .modifiedCompetition),
      ([-.infinity, -.infinity, .infinity, .infinity], <, [2, 2, 4, 4], .modifiedCompetition),

      ([.infinity, .pi, -.infinity, -.pi], <, [4, 3, 1, 2], .standardCompetition),
      ([-.infinity, -.infinity, .infinity, .infinity], <, [1, 1, 3, 3], .standardCompetition),

      ([.infinity, .pi, -.infinity, -.pi], <, [4, 3, 1, 2], .ordinal),
      ([-.infinity, -.infinity, .infinity, .infinity], <, [1, 2, 3, 4], .ordinal),
    ] as RankingInput<Double>
  )
  func validFloatingPointDataSets(
    data: [Double],
    ordering: @escaping (Double, Double) -> Bool,
    expectedRank: [Double],
    strategy: RankingStrategy
  ) async {
    #expect(data.rank(variable: \.self, by: ordering, strategy: strategy) == expectedRank)
  }
}
