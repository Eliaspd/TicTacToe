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
    
    
    var playerOne: Player?
    var playerTwo: Player?
    
    var initialXposition: CGPoint = CGPoint.zero
    var initialOposition: CGPoint = CGPoint.zero
    
    //var ticTacToeGame = TicTacToe()
    
  //  var droppedInSquare: Bool?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        initialXposition = xPlayer.center
        initialOposition = oPlayer.center
        for square in boardSquares {
            
            print("Square \(square.frame)")
            
        }
        
    }
    
    
    
    @IBAction func xPlayerGesture(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: self.view)
        
        xPlayer.center = CGPoint(x: translation.x + xPlayer.center.x, y: translation.y + xPlayer.center.y)
        
        sender.setTranslation(CGPoint.zero, in: self.view)

        if sender.state == .ended {
            
            var droppedInSquare = false
            
            for square in boardSquares {
                // Convert the square's frame to the view's coordinate system
                let squareFrameInSuperview = square.superview?.convert(square.frame, to: self.view) ?? square.frame
                
                // Check if xPlayer's frame intersects with the square's frame
                if squareFrameInSuperview.intersects(xPlayer.frame) {
                    // If intersection occurs, snap xPlayer to the center of the square
                    xPlayer.center = square.center
                    square.image = self.xPlayer.image
                    square.tintColor = xPlayer.tintColor
                    droppedInSquare = true
                    print("Dropped X at: \(xPlayer.center)")
                    break
                }
            }
            
            // If the piece wasn't dropped in a square, reset it to its initial position
            if !droppedInSquare {
                
                UIView.animate(withDuration: 0.3) {
                    self.xPlayer.center = self.initialXposition
                    
                }
            }
        }
    }


    
    @IBAction func oPlayerGesture(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: self.view)
        oPlayer.center = CGPoint(x: translation.x + oPlayer.center.x, y: translation.y + oPlayer.center.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
        
        if sender.state == .ended {
            
            var droppedInSquare = false // Flag to track if the O piece was dropped in a valid square
            
            for square in boardSquares {
                
                let squareFrameInSuperview = square.superview?.convert(square.frame, to: self.view) ?? square.frame
                let oFrameInSuperview = oPlayer.superview?.convert(oPlayer.frame, to: self.view) ?? oPlayer.frame
                
                if squareFrameInSuperview.contains(oFrameInSuperview) {
                    // Snap the O piece to the square
                    self.oPlayer.center = square.center
                    square.image = self.oPlayer.image
                    square.tintColor = oPlayer.tintColor
                    droppedInSquare = true // Mark that the piece was successfully dropped in a square
                    print("Dropped O at: \(oPlayer.center)")
                    break
                }
            }
            
            // If the piece wasn't dropped in a valid square, reset its position
            if !droppedInSquare {
                UIView.animate(withDuration: 0.3) {
                    self.oPlayer.center = self.initialOposition
                }
            }
        }
    }

    @IBAction func resetGame(_ sender: UIButton) {
    }
    
    
}


