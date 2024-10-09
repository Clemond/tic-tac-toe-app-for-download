//
//  GameViewController.swift
//  TicTacToeApp
//
//  Created by Nicholas Nieminen Jönsson on 2024-09-08.
//

import UIKit

class GameViewController: UIViewController {
    
    // All stack views
    @IBOutlet weak var firstVerticalStack: UIStackView!
    @IBOutlet weak var secondVerticalStack: UIStackView!
    @IBOutlet weak var thirdVerticalStack: UIStackView!
    // Label outlets
    @IBOutlet weak var lblPlayerOne: UILabel!
    @IBOutlet weak var lblPlayerTwo: UILabel!
        
    var playersTurn: Bool = true
    let myGame = Game()
    
    var playingBoard = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    let checkFirstHorizontalRow = [0, 1, 2]
    let checkSecondHorizontalRow = [3, 4, 5]
    let checkThirdHorizontalRow = [6, 7, 8]
    
    let checkFirstVerticalRow = [0, 3, 6]
    let checkSecondVerticalRow = [1, 4, 7]
    let checkThirdVerticalRow = [2, 5, 8]
    
    let checkleftDiagonal = [0, 4, 8]
    let checkRightDiagonal = [2, 4, 6]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblPlayerOne.text = myGame.getPlayerName(id: 1)
        lblPlayerTwo.text = myGame.getPlayerName(id: 2)
        
        highlightCurrentPlayerLabel()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onTapGesture(_ sender: UITapGestureRecognizer) {
        
        // Check that there is a view
        if let view = sender.view {
            //Check if the current box is already used
            if view.isUserInteractionEnabled == true {
                
                if playersTurn  == true {
                    if let currentPlayerSymbol = myGame.findPlayerById(id: 1)?.symbol  {
                        
                        addLabelOnView(on: view, withText: currentPlayerSymbol)
                        updatePlayingBoard(boxIndex: view.tag)
                        view.isUserInteractionEnabled = false
                        
                    }
                }else  {
                    if let currentPlayerSymbol = myGame.findPlayerById(id: 2)?.symbol  {
                        
                        addLabelOnView(on: view, withText: currentPlayerSymbol)
                        updatePlayingBoard(boxIndex: view.tag)
                        view.isUserInteractionEnabled = false
                        
                    }
                }
                checkWinner()
                playersTurn.toggle()
                highlightCurrentPlayerLabel()
            }
        }
        
    }
    
    func highlightCurrentPlayerLabel() {
        if playersTurn {
            lblPlayerOne.textColor = UIColor.blue
            lblPlayerTwo.textColor = UIColor.black
        }
        else {
            lblPlayerOne.textColor = UIColor.black
            //lblPlayerTwo.textColor = UIColor.blue
        }
        
    }
    
    func addLabelOnView(on imageView: UIView, withText text: String) {
        let label = UILabel()
        
        label.text = text
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 60)
        
        // Set label to match imageView bounds
        label.frame = imageView.bounds
        
        // Add label to imageView
        imageView.addSubview(label)
        
        // Update the layout after adding the label
        imageView.layoutIfNeeded()
    }
    
    
    func updatePlayingBoard(boxIndex: Int){
        
        if playersTurn == true {
            playingBoard[boxIndex - 1] = 1
        } else {
            playingBoard[boxIndex - 1] = 2
        }
    }
    
    func checkWinner(){
        
        if checkFirstHorizontalRow.allSatisfy({ playingBoard[$0] == 1}) || checkFirstHorizontalRow.allSatisfy({ playingBoard[$0] == 2}){
            getWinner(playingBoardIndexToCheck: 0)
            return
        }
        else if checkSecondHorizontalRow.allSatisfy({ playingBoard[$0] == 1}) || checkSecondHorizontalRow.allSatisfy({ playingBoard[$0] == 2}){
            getWinner(playingBoardIndexToCheck: 3)
            return
        }
        else if checkThirdHorizontalRow.allSatisfy({ playingBoard[$0] == 1}) || checkThirdHorizontalRow.allSatisfy({ playingBoard[$0] == 2}){
            getWinner(playingBoardIndexToCheck: 6)
            return
        }
        else if checkleftDiagonal.allSatisfy({ playingBoard[$0] == 1}) || checkleftDiagonal.allSatisfy({ playingBoard[$0] == 2}){
            getWinner(playingBoardIndexToCheck: 0)
            return
        }
        else if checkRightDiagonal.allSatisfy({ playingBoard[$0] == 1}) || checkRightDiagonal.allSatisfy({ playingBoard[$0] == 2}){
            getWinner(playingBoardIndexToCheck: 2)
            return
        }
        else if checkFirstVerticalRow.allSatisfy({playingBoard[$0] == 1}) || checkFirstVerticalRow.allSatisfy({playingBoard[$0] == 2}){
            getWinner(playingBoardIndexToCheck: 0)
            return
        }
        else if checkSecondVerticalRow.allSatisfy({playingBoard[$0] == 1}) || checkSecondVerticalRow.allSatisfy({playingBoard[$0] == 2}){
            getWinner(playingBoardIndexToCheck: 1)
            return
        }
        else if checkThirdVerticalRow.allSatisfy({playingBoard[$0] == 1}) || checkThirdVerticalRow.allSatisfy({playingBoard[$0] == 2}){
            getWinner(playingBoardIndexToCheck: 2)
            return
        }
        
        if !playingBoard.contains(0){
            tieAlert()
        }
        
    }
    
    func getWinner(playingBoardIndexToCheck: Int){
        if playingBoard[playingBoardIndexToCheck] == 1 {
            myGame.updatePlayerScore(id: 1)
            winnerAlert(id: 1)
        } else if playingBoard[playingBoardIndexToCheck] == 2{
            myGame.updatePlayerScore(id: 2)
            winnerAlert(id: 2)
        }
    }
    
    
    func winnerAlert(id: Int){
        let alert = UIAlertController(title: "\(myGame.getPlayerName(id: id)) WON!",
                                      message: "\(myGame.getPlayerName(id: 1)) score: \(myGame.getPlayerScore(id: 1)). \(myGame.getPlayerName(id: 2)) score: \(myGame.getPlayerScore(id: 2))",
                                      preferredStyle: .alert)
        // Add a button
        let playAgainActionButton = UIAlertAction(title: "New round",
                                                  style: .default) { _ in self.playAgainReset()}
        let quitGameActionButton = UIAlertAction(title: "Quit game", style: .default){ _ in self.quitGame()}
        
        alert.addAction(quitGameActionButton)
        alert.addAction(playAgainActionButton)
        // present the alert on screen
        self.present(alert, animated: true, completion: nil)
    }
    
    func tieAlert(){
        let alert = UIAlertController(title: "It's a tie",
                                      message: "No points given this round",
                                      preferredStyle: .alert)
        // Add a button
        let playAgainActionButton = UIAlertAction(title: "New round",
                                                  style: .default) { _ in self.playAgainReset()}
        let quitGameActionButton = UIAlertAction(title: "Quit game", style: .default){ _ in self.quitGame()}

        alert.addAction(quitGameActionButton)
        alert.addAction(playAgainActionButton)
        // present the alert on screen
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func playAgainReset(){
        // Remove all labels from the game board views and enable user interaction
        let allViews = [firstVerticalStack, secondVerticalStack, thirdVerticalStack]
        
        for stackView in allViews {
            for view in stackView?.arrangedSubviews ?? [] {
                view.isUserInteractionEnabled = true
                for subview in view.subviews {
                    subview.removeFromSuperview()
                }
            }
        }
            
        // Reset the playing board and game state
        playingBoard = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        playersTurn = true
        highlightCurrentPlayerLabel()
    }
    
    func quitGame(){
        self.dismiss(animated: true, completion: nil)
    }
    
}
