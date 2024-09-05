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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initialXposition = xPlayer.center
    }
    
    

    @IBAction func xPlayerGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        
        xPlayer.center = CGPoint(x: translation.x + xPlayer.center.x, y: translation.y + xPlayer.center.y)
        
        sender.setTranslation(CGPoint.zero, in: self.view)
        
       
    }
    
    @IBAction func oPlayerGesture(_ sender: UIPanGestureRecognizer) {
    }
    
    
    
}


