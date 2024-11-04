//
//  SelectPlayersViewController.swift
//  TicTacToeApp
//
//  Created by Nicholas Nieminen Jönsson on 2024-09-08.
//

import UIKit

class SelectPlayersViewController: UIViewController {
    
    
    @IBOutlet weak var txtPlayerOneInput: UITextField!
    @IBOutlet weak var txtPlayerTwoInput: UITextField!
    
    var playerOne: String = ""
    var playerTwo: String = ""
    
    let segueToGameViewController = "segueToGameViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnStartGame(_ sender: UIButton) {
        
        if let player1 = txtPlayerOneInput.text,
           let player2 = txtPlayerTwoInput.text {
            playerOne = player1
            playerTwo = player2
        }
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == segueToGameViewController {
            if let destinationVC = segue.destination as? GameViewController {
                destinationVC.myGame.addPlayer(userName: playerOne )
                destinationVC.myGame.addPlayer(userName: playerTwo)
            }
        }
        
        
    }
    

}
