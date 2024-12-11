//
//  ViewController.swift
//  TicTacToe
//
//  Created by Elias Puolitaival on 2024-09-03.
//
import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var boardSquares: [UIImageView]!
    @IBOutlet weak var xPlayer: UIImageView!
    @IBOutlet weak var oPlayer: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    
    var game: TicTacToe!
    var initialXposition: CGPoint = CGPoint.zero
    var initialOposition: CGPoint = CGPoint.zero
    var droppedInSquare = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let playerX = Player(score: 0, userName: "Player X", type: .x)
        let playerO = Player(score: 0, userName: "Player O", type: .o)
        game = TicTacToe(playerX: playerX, playerO: playerO)
        
        initialXposition = xPlayer.center
        initialOposition = oPlayer.center
        
        updateStatusLabel()
    }

    @IBAction func resetGame(_ sender: UIButton) {
        game.resetGame()
        resetBoardUI()
        updateStatusLabel()
    }
    
    @IBAction func xPlayerGesture(_ sender: UIPanGestureRecognizer) {
        handlePlayerGesture(sender, player: xPlayer, initialPosition: initialXposition)
    }

    @IBAction func oPlayerGesture(_ sender: UIPanGestureRecognizer) {
        handlePlayerGesture(sender, player: oPlayer, initialPosition: initialOposition)
    }

    private func handlePlayerGesture(_ sender: UIPanGestureRecognizer, player: UIImageView, initialPosition: CGPoint) {
        let translation = sender.translation(in: self.view)
        player.center = CGPoint(x: translation.x + player.center.x, y: translation.y + player.center.y)
        sender.setTranslation(.zero, in: self.view)

        if sender.state == .ended {
            droppedInSquare = false
            
            for square in boardSquares {
                let squareFrame = square.superview?.convert(square.frame, to: self.view) ?? square.frame
                let playerFrame = player.superview?.convert(player.frame, to: self.view) ?? player.frame
                
                if squareFrame.contains(playerFrame) {
                    droppedInSquare = true
                    square.image = player.image
                    square.tintColor = player.tintColor
                    
                    if let index = boardSquares.firstIndex(of: square) {
                        let row = index / 3
                        let col = index % 3
                        if game.makeMove(row: row, col: col) {
                            updateStatusLabel()
                            
                            if game.gameState != .ongoing {
                                handleGameEnd()
                            }
                        }
                    }

                    UIView.animate(withDuration: 0.3) {
                        player.center = initialPosition
                    }
                    break
                }
            }
            
            if !droppedInSquare {
                UIView.animate(withDuration: 0.3) {
                    player.center = initialPosition
                }
            }
        }
    }

    private func resetBoardUI() {
        let initialSquareImage = UIImage(systemName: "B1")
        for square in boardSquares {
            square.image = initialSquareImage
        }
        UIView.animate(withDuration: 0.3) {
            self.xPlayer.center = self.initialXposition
            self.oPlayer.center = self.initialOposition
        }
    }
    
    private func updateStatusLabel() {
        switch game.gameState {
        case .ongoing:
            statusLabel.text = "\(game.currentPlayer.userName)'s turn"
        case .draw:
            statusLabel.text = "It's a draw!"
        case .win(let winner):
            statusLabel.text = "\(winner.userName) wins!"
        }
    }
    private func showWinAlert(winningPlayer: Player) {
        let alert = UIAlertController(
            title: "Congratulations!",
            message: "\(winningPlayer.userName) wins!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }

    private func showDrawAlert() {
        let alert = UIAlertController(
            title: "It's a Draw!",
            message: "No more moves left!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    private func handleGameEnd() {
        switch game.gameState {
        case .win(let winner):
            showWinAlert(winningPlayer: winner)
        case .draw:
            showDrawAlert()
        case .ongoing:
            break
        }
    }
    
   
}
