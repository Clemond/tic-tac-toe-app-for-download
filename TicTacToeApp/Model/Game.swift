//
//  Game.swift
//  TicTacToeApp
//
//  Created by Nicholas Nieminen Jönsson on 2024-09-05.
//

import Foundation

class Game {
    
    private var currentPlayers: [Player] = []
    
    func addPlayer(userName: String){
        
        if currentPlayers.count < 2 {
            
            if currentPlayers.count == 0 {
                let newPlayer = Player(
                    name: userName,
                    symbol: "X",
                    score: 0,
                    id: 1)
                currentPlayers.append(newPlayer)
                
            } else if currentPlayers.count == 1 {
                let newPlayer = Player(
                    name: userName,
                    symbol: "O",
                    score: 0,
                    id: 2)
                currentPlayers.append(newPlayer)
            }
        }else {
            print("No more player slots avalible")
        }
    }
    
    func getCurrentPlayers() -> [Player]{
            return currentPlayers
    }
    
    func findPlayerById(id: Int) -> Player? {
        let maybeFoundPlayer = currentPlayers.first { $0.id == id}
        return maybeFoundPlayer
    }
    
    func updatePlayerScore(id: Int) {
    
        var userID = id
        userID -= 1
        
        var currentPlayerWithIndex = currentPlayers[userID]
        currentPlayerWithIndex.score += 1
            
        currentPlayers[userID] = currentPlayerWithIndex
    }
    
    func deleteAllCurrentPlayers() {
        currentPlayers.removeAll()
    }
    
    func getPlayerScore(id: Int) -> Int{
        guard let maybeFoundScore = findPlayerById(id: id)?.score else { return 404 }
        return maybeFoundScore
    }

    func getPlayerName(id: Int) -> String{
        
        guard let maybeFoundPlayer = findPlayerById(id: id)?.name else { return "No player found" }
        return maybeFoundPlayer
    }
}
    

