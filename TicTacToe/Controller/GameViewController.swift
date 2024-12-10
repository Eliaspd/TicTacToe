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
    
    var squareFrame: CGRect = .zero
    var oFrame: CGRect = .zero
    var xFrame: CGRect = .zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialXposition = xPlayer.center
        initialOposition = oPlayer.center
    }
    
    @IBAction func xPlayerGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        
        xPlayer.center = CGPoint(x: translation.x + xPlayer.center.x, y: translation.y + xPlayer.center.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
        
        if sender.state == .ended {
            var droppedInSquare = false
            
            for square in boardSquares {
                
                squareFrame = square.superview?.convert(square.frame, to: self.view) ?? square.frame
                xFrame = xPlayer.superview?.convert(xPlayer.frame, to: self.view) ?? xPlayer.frame
                
               
                if squareFrame.contains(xFrame) {
                    xPlayer.center = square.center
                    square.image = self.xPlayer.image
                    square.tintColor = xPlayer.tintColor
                    droppedInSquare = true
                    print("Dropped X at: \(xPlayer.center)")
                    break
                }
            }
            
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
            var droppedInSquare = false
            
            for square in boardSquares {
              
                squareFrame = square.superview?.convert(square.frame, to: self.view) ?? square.frame
                oFrame = oPlayer.superview?.convert(oPlayer.frame, to: self.view) ?? oPlayer.frame
                
               
                if squareFrame.contains(oFrame) {
                    oPlayer.center = square.center
                    square.image = self.oPlayer.image
                    square.tintColor = oPlayer.tintColor
                    droppedInSquare = true
                    print("Dropped O at: \(oPlayer.center)")
                    break
                }
            }
            
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


