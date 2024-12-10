//
//  TicTacToePlayer.swift
//  TicTacToe
//
//  Created by Elias Puolitaival on 2024-09-03.
//

import Foundation

struct Player: Equatable {
    enum PlayerType {
        case x
        case o
    }
    
    var score: Int
    var userName: String
    var type: PlayerType
}


