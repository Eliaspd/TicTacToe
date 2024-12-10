//
//  TicTacToe.swift
//  TicTacToe
//
//  Created by Elias Puolitaival on 2024-09-03.
//

import Foundation

class TicTacToe {
    enum CellState {
        case empty
        case x
        case o
    }
    
    enum GameState: Equatable {
        case ongoing
        case draw
        case win(Player)
    }

    
    private var board: [[CellState]]
    private(set) var currentPlayer: Player
    private let playerX: Player
    private let playerO: Player
    private(set) var gameState: GameState
    
    init(playerX: Player, playerO: Player) {
        self.board = Array(repeating: Array(repeating: .empty, count: 3), count: 3)
        self.playerX = playerX
        self.playerO = playerO
        self.currentPlayer = playerX
        self.gameState = .ongoing
    }
    
    func makeMove(row: Int, col: Int) -> Bool {
        guard gameState == .ongoing else { return false }
        guard row >= 0 && row < 3 && col >= 0 && col < 3 else { return false }
        guard board[row][col] == .empty else { return false }
        
        // Update the board with the current player's move
        board[row][col] = currentPlayer.type == .x ? .x : .o
        
        if checkForWinner() {
            gameState = .win(currentPlayer)
            currentPlayer.score += 1
        } else if checkForDraw() {
            gameState = .draw
        } else {
            toggleCurrentPlayer()
        }
        
        return true
    }
    
    func resetGame() {
        board = Array(repeating: Array(repeating: .empty, count: 3), count: 3)
        gameState = .ongoing
        currentPlayer = playerX
    }
    
    private func toggleCurrentPlayer() {
        currentPlayer = (currentPlayer.type == .x) ? playerO : playerX
    }
    
    private func checkForWinner() -> Bool {
        // Check rows and columns
        for i in 0..<3 {
            if board[i][0] != .empty && board[i][0] == board[i][1] && board[i][1] == board[i][2] {
                return true
            }
            if board[0][i] != .empty && board[0][i] == board[1][i] && board[1][i] == board[2][i] {
                return true
            }
        }
        
        // Check diagonals
        if board[0][0] != .empty && board[0][0] == board[1][1] && board[1][1] == board[2][2] {
            return true
        }
        if board[0][2] != .empty && board[0][2] == board[1][1] && board[1][1] == board[2][0] {
            return true
        }
        
        return false
    }
    
    private func checkForDraw() -> Bool {
        return !board.flatMap { $0 }.contains(.empty)
    }
}
