//
//  GameViewController.swift
//  TicTacToeApp
//
//  Created by Nicholas Nieminen Jönsson on 2024-09-08.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var firstVerticalStack: UIStackView!
    @IBOutlet weak var secondVerticalStack: UIStackView!
    @IBOutlet weak var thirdVerticalStack: UIStackView!
    
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
        
        guard let view = sender.view, view.isUserInteractionEnabled else {
            return
        }
        
        let playerId = playersTurn ? 1 : 2
        if let currentPlayerSymbol = myGame.findPlayerById(id: playerId)?.symbol {
            
            addLabelOnView(imageView: view, text: currentPlayerSymbol)
            updatePlayingBoard(boxIndex: view.tag)
            
            view.isUserInteractionEnabled = false
        }
        
        checkWinner()
        playersTurn.toggle()
        highlightCurrentPlayerLabel()
        
    }
    
    func highlightCurrentPlayerLabel() {
        if playersTurn {
            lblPlayerOne.textColor = UIColor.blue
            lblPlayerTwo.textColor = UIColor.black
        }
        else {
            lblPlayerOne.textColor = UIColor.black
            lblPlayerTwo.textColor = UIColor.blue
        }
        
    }
    
    func addLabelOnView(imageView: UIView, text: String) {
        let label = UILabel()
        
        label.text = text
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 60)
        
        label.frame = imageView.bounds
        
        imageView.addSubview(label)
        
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
        
        let winningCombinations = [
            (checkFirstHorizontalRow, 0),
            (checkSecondHorizontalRow, 3),
            (checkThirdHorizontalRow, 6),
            (checkleftDiagonal, 0),
            (checkRightDiagonal, 2),
            (checkFirstVerticalRow, 0),
            (checkSecondVerticalRow, 1),
            (checkThirdVerticalRow, 2)
        ]
        
        for (combination, indexToCheck) in winningCombinations {
            if combination.allSatisfy({ playingBoard[$0] == 1 }) || combination.allSatisfy({ playingBoard[$0] == 2 }) {
                getWinner(playingBoardIndexToCheck: indexToCheck)
                return
            }
        }
        
        if !playingBoard.contains(0) {
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
        let alert = UIAlertController(
            title: "\(myGame.getPlayerName(id: id)) WON!",
            message: "\(myGame.getPlayerName(id: 1)) score: \(myGame.getPlayerScore(id: 1)). \(myGame.getPlayerName(id: 2)) score: \(myGame.getPlayerScore(id: 2))",
            preferredStyle: .alert)
        
        let playAgainActionButton = UIAlertAction(
            title: "New round",
            style: .default) { _ in self.playAgainReset()}
        
        let quitGameActionButton = UIAlertAction(
            title: "Quit game",
            style: .default){ _ in self.quitGame()}
        
        alert.addAction(quitGameActionButton)
        alert.addAction(playAgainActionButton)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func tieAlert(){
        let alert = UIAlertController(
            title: "It's a tie",
            message: "No points given this round",
            preferredStyle: .alert)
        
        let playAgainActionButton = UIAlertAction(
            title: "New round",
            style: .default) { _ in self.playAgainReset()}
        
        let quitGameActionButton = UIAlertAction(
            title: "Quit game",
            style: .default){ _ in self.quitGame()}
        
        alert.addAction(quitGameActionButton)
        alert.addAction(playAgainActionButton)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func playAgainReset(){
        
        let allViews = [firstVerticalStack, secondVerticalStack, thirdVerticalStack]
        
        for stackView in allViews {
            for view in stackView?.arrangedSubviews ?? [] {
                view.isUserInteractionEnabled = true
                for subview in view.subviews {
                    subview.removeFromSuperview()
                }
            }
        }
        
        playingBoard = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        playersTurn = true
        highlightCurrentPlayerLabel()
    }
    
    func quitGame(){
        self.dismiss(animated: true, completion: nil)
    }
}
