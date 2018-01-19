import Foundation

// Challenge 1: Compute factorial of an integer
func factorial(_ n: Int) -> Int {
    guard n >= 0 else {
        return -1
    }
    
    if n <= 1 {
        return 1
    }
    
    return n * factorial(n - 1)
}

// Challege 2: Compute gcd of two integers
func gcd(a: Int, b: Int) -> Int {
    guard b != 0 else {
        return a >= 0 ? a : -a
    }
    
    return gcd(a: b, b: a % b)
}

// Challenge 3: Integer Array Permutations
func permute(_ array: [Int]) -> [[Int]] {
    var result = [[Int]]()
    if array.count <= 1 {
        result.append(array)
        return result
    }
    
    for i in 0 ..< array.count {
        let current = array[i]
        var remaining = [Int]()
        for j in 0 ..< array.count {
            if j != i {
                remaining.append(array[j])
            }
        }
        
        let permuteRemaining = permute(remaining)
        for permuted in permuteRemaining {
            var permuted = permuted
            permuted.insert(current, at: 0)
            result.append(permuted)
        }
    }
    return result
}

// Challenge 4: Compute all substrings
func getSubstrings(_ s: String) -> [String] {
    var result = [String]()
    for i in 0 ..< s.count {
        for j in i + 1 ... s.count {
            let start = s.index(s.startIndex, offsetBy: i)
            let end = s.index(s.startIndex, offsetBy: j)
            result.append(String(s[start ..< end]))
        }
    }
    return result
}

// Challenge 5: Single Number
func singleNumber(_ array: [Int]) -> Int {
    return array.reduce(0, ^)
}

// Challenge 6: Number of 1 bits
func countOneBits(_ n: Int) -> Int {
    var n = n
    var result = 0
    while n != 0 {
        result += 1
        n &= n - 1
    }
    
    return result
}

// Interview Question 1 - Towers of Hanoi
class HanoiSolution {
    enum Move: String {
        case AB, AC, BA, BC, CA, CB
    }
    
    func solve(n: Int) -> [Move] {
        var result = [Move]()
        move(n: n, start: "A", temp: "B", target: "C", result: &result)
        return result
    }
    
    /**
     Helper function to solve the Tower of Hanoi problem
     
     - parameters:
        - n: Number of pieces to move
        - start: The pole that the n pieces are currently on
        - temp: The pole that is not the target
        - target: The pole that we want the n pieces to move to
        - result: The resulting array of Moves
    */
    private func move(n: Int, start: String, temp: String, target: String, result: inout [Move]) {
        if n > 0 {
            move(n: n - 1, start: start, temp: target, target: temp, result: &result)
            result.append(Move(rawValue: "\(start)\(target)")!)
            move(n: n - 1, start: temp, temp: start, target: target, result: &result)
        }
    }
}

// Interview Question 2: Calculating n choose k
func calculate(from n: Int, choose k: Int) -> Int {
    switch k {
    case let x where x > n:
        return 0
    case 1:
        return n
    case 0, n:
        return 1
    default:
        break
    }
    
    var mem = [[Int]](repeating: [Int](repeating: 0, count: k + 1), count: n + 1)
    for i in 2 ... n {
        for j in 0 ... min(i, k) {
            switch j {
            case 0, i:
                mem[i][j] = 1
            case 1:
                mem[i][j] = i
            default:
                mem[i][j] = mem[i - 1][j - 1] + mem[i - 1][j]
            }
        }
    }
    
    return mem[n][k]
}
