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
        
        for square in boardSquares {
            
            let squareFrameInSuperview = square.superview?.convert(square.frame, to: self.view) ?? square.frame
            let oFrameInSuperview = xPlayer.superview?.convert(xPlayer.frame, to: self.view) ?? xPlayer.frame
            
            if squareFrameInSuperview.contains(oFrameInSuperview) {
                
                    self.xPlayer.center = square.center
                    square.image = self.xPlayer.image
                    square.tintColor = xPlayer.tintColor
                
                //droppedInSquare = true
                break
            }
            
        }
        
        
        if sender.state == .ended {
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
            
            for square in boardSquares {
                
                let squareFrameInSuperview = square.superview?.convert(square.frame, to: self.view) ?? square.frame
                let oFrameInSuperview = oPlayer.superview?.convert(oPlayer.frame, to: self.view) ?? oPlayer.frame
                
                if squareFrameInSuperview.contains(oFrameInSuperview) {
                    
                        self.oPlayer.center = square.center
                        square.image = self.oPlayer.image
                        square.tintColor = oPlayer.tintColor
                    
                    //droppedInSquare = true
                    break
                }
                
            }
            
            
            if sender.state == .ended {
                UIView.animate(withDuration: 0.3) {
                    self.oPlayer.center = self.initialOposition
                }
            }
        }
    }
    
    
}


