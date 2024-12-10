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
    
    var initialXposition: CGPoint = CGPoint.zero
    var initialOposition: CGPoint = CGPoint.zero
    var droppedInSquare = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialXposition = xPlayer.center
        initialOposition = oPlayer.center
    }

    @IBAction func resetGame(_ sender: UIButton) {
        let initialSquareImage = UIImage(systemName: "B1")
        for square in boardSquares {
            square.image = initialSquareImage
        }
        UIView.animate(withDuration: 0.3) {
            self.xPlayer.center = self.initialXposition
            self.oPlayer.center = self.initialOposition
        }
        droppedInSquare = false
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
                    player.center = square.center
                    square.image = player.image
                    square.tintColor = player.tintColor
                    droppedInSquare = true
                    player.center = initialPosition
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
}
