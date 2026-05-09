internal struct WalkersAliasTable {
    let prob: [Double]
    let alias: [Int]

    init(weights: [Double]) {
        let n = weights.count
        let sum = weights.reduce(0, +)
        // Normalise so probabilities sum to n (one per column)
        var scaled = weights.map { $0 * Double(n) / sum }

        var prob  = [Double](repeating: 0, count: n)
        var alias = [Int](repeating: 0, count: n)

        var small = [Int]()
        var large = [Int]()

        for i in 0 ..< n {
            if scaled[i] < 1.0 {
                small.append(i)
            } else {
                large.append(i)
            }
        }

        while !small.isEmpty && !large.isEmpty {
            let s = small.removeLast()
            let l = large.removeLast()

            prob[s]  = scaled[s]
            alias[s] = l

            // Donate the leftover from l to fill s's column
            scaled[l] -= (1.0 - scaled[s])

            if scaled[l] < 1.0 {
                small.append(l)
            } else {
                large.append(l)
            }
        }

        // Numerical rounding — anything left is effectively probability 1
        for i in small + large { prob[i] = 1.0 }

        self.prob  = prob
        self.alias = alias
    }

    func sample(using rng: inout some RandomNumberGenerator) -> Int {
        let n = prob.count
        let i = Int.random(in: 0 ..< n, using: &rng)
        let coin = Double.random(in: 0 ..< 1, using: &rng)
        return coin < prob[i] ? i : alias[i]
    }
}
