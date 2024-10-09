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
        
        //If there already are two players in the list, it wont be posible to add a third
        if currentPlayers.count < 2 {
            
            if currentPlayers.count == 0 {
                let newPlayer = Player(name: userName, symbol: "X",score: 0, id: 1 )
                currentPlayers.append(newPlayer)
            } else if currentPlayers.count == 1 {
                let newPlayer = Player(name: userName, symbol: "O", score: 0, id: 2 )
                currentPlayers.append(newPlayer)
            }
            
        }else {
            print("No more player slots avalible")
            }
        }
    
    
    // get all current players
    func getCurrentPlayers() -> [Player]{
            return currentPlayers
    }
    
    // find player based on id
    func findPlayerById(id: Int) -> Player? {
        let maybeFoundPlayer = currentPlayers.first { $0.id == id}
        return maybeFoundPlayer
        
    }
    
    // Update users score
    func updatePlayerScore(id: Int) {
    
        var userID = id
        userID -= 1
        
            // Create a copy of the user whose score we want to update
            var currentPlayerWithIndex = currentPlayers[userID]
            currentPlayerWithIndex.score += 1
            
            // Make the copy's value the real user's score in the list
            currentPlayers[userID] = currentPlayerWithIndex
    }
    
    // Remove all players from list
    func deleteAllCurrentPlayers() {
        currentPlayers.removeAll()
    }
    // Get player score
    func getPlayerScore(id: Int) -> Int{
        guard let maybeFoundScore = findPlayerById(id: id)?.score else { return 404 }
        return maybeFoundScore
    }
    // Get player name
    func getPlayerName(id: Int) -> String{
        
        guard let maybeFoundPlayer = findPlayerById(id: id)?.name else { return "No player found" }
        return maybeFoundPlayer
        
    }
    
    }
    

