/**
 Given a 2D board containing 'X' and 'O', capture all regions surrounded by 'X'.
 
 A region is captured by flipping all 'O's into 'X's in that surrounded region.
 
 For example,
 
 X X X X
 X O O X
 X X O X
 X O X X
 
 After running your function, the board should be:
 
 X X X X
 X X X X
 X X X X
 X O X X
 */

import Foundation

// Some constants
let notCapturable: Character = "N"
let flipped: Character = "X"
let unflipped: Character = "O"

// dr and dc, represent changes to row and col to get to board position that are in this order:
// right, down, left, up
let dr = [0, 1, 0, -1]
let dc = [1, 0, -1, 0]

func isValid(row: Int, col: Int, within board: [[Character]]) -> Bool {
    let rows = board.count
    let cols = board[0].count
    
    return row >= 0 && row < rows && col >= 0 && col < cols && board[row][col] == unflipped
}

func bfs(_ board: inout [[Character]], _ r: Int, _ c: Int, _ target: Character) {
    var queue = [(r, c)]
    while !queue.isEmpty {
        let (r, c) = queue.removeFirst()
        board[r][c] = target
        
        for i in 0 ..< dr.count {
            let nextR = r + dr[i]
            let nextC = c + dc[i]
            
            if isValid(row: nextR, col: nextC, within: board) {
                queue.append((nextR, nextC))
            }
        }
    }
}

func capture(board: inout [[Character]]) {
    // Empty array or board with only one row/col
    if board.count <= 1 || board[0].count <= 1 {
        return
    }
    
    let rows = board.count
    let cols = board[0].count
    
    // Run bfs on edge O's, mark all connected O's from the edge as not capturable
    for r in 0 ..< rows {
        var range: [Int]!
        if r == 0 || r == rows - 1 {
            range = [Int](0 ..< cols)
        } else {
            range = [0, cols - 1]
        }
        
        for c in range {
            if board[r][c] == unflipped {
                bfs(&board, r, c, notCapturable)
            }
        }
    }
    
    // Any remaining O's on the board can be captured, any N's can be changed to O's
    for r in 0 ..< rows {
        for c in 0 ..< cols {
            switch board[r][c] {
            case unflipped:
                board[r][c] = flipped
            case notCapturable:
                board[r][c] = unflipped
            default:
                break
            }
        }
    }
}

var board: [[Character]] = [
    ["X", "X", "X", "O", "O", "X", "X", "X", "X"],
    ["X", "O", "X", "O", "O", "X", "O", "O", "X"],
    ["X", "O", "X", "X", "X", "X", "O", "O", "X"],
    ["X", "O", "O", "O", "O", "O", "X", "X", "X"],
    ["X", "X", "X", "X", "X", "X", "O", "O", "X"],
    ["X", "X", "O", "O", "X", "X", "X", "O", "X"],
    ["X", "X", "O", "O", "O", "O", "X", "O", "O"],
    ["O", "X", "X", "X", "O", "O", "O", "X", "X"],
    ["O", "X", "O", "O", "X", "X", "X", "O", "X"],
    ["O", "X", "X", "X", "X", "O", "O", "X", "X"],
]

var small: [[Character]] = [
    ["X", "X", "X", "X"],
    ["X", "O", "O", "X"],
    ["X", "X", "O", "X"],
    ["X", "O", "X", "X"]
]

var edge: [[Character]] = [
    ["X", "O", "X"],
    ["X", "O", "X"],
    ["X", "O", "X"]
]

func show(_ board: [[Character]]) {
    for r in 0 ..< board.count {
        var row = "   "
        for c in 0 ..< board[r].count {
            row += "\(board[r][c]) "
        }
        print(row)
    }
}

func test(_ board: inout [[Character]]) {
    show(board)
    print("=============================================================")
    print("=============================================================")
    capture(board: &board)
    show(board)
}

test(&edge)

