//
//  Memento Pattern.swift
//  Design Patterns
//
//  Created by aleksandre on 10.06.22.
//


/* • The memento pattern allows an object to be saved and restored. It involves three types: the originator, memento and caretaker.
   • The originator is the object to be saved; the memento is a saved state; and the caretaker handles, persists and retrieves mementos.
   • iOS provides Encoder for encoding a memento to, and Decoder for decoding from, a memento. This allows encoding and decoding logic to be used across originators. */


import Foundation


// MARK: -- Originator
public class Game: Codable {
    
    public class State: Codable {
        public var attemptsRemaining: Int = 3
        public var level: Int = 1
        public var score: Int = 0
    }
    
    public var state = State()
    
    public func rackUpMassivePoints() {
        state.score += 9000
        
    }
    
    public func monstersEatPlayer() {
        state.attemptsRemaining -= 1
    }
}

// MARK: -- Memento
typealias GameMemento = Data


// MARK: -- CareTaker
public class GameSystem {
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let userDefaults = UserDefaults.standard
    
    public func save(_ game: Game, title: String) throws {
        let data = try encoder.encode(game)
        userDefaults.set(data, forKey: title)
    }
    
    public func load(_ title: String) throws -> Game {
        guard let data = userDefaults.data(forKey: title),
              let game = try? decoder.decode(Game.self, from: data)
        else {
            // Your fav error handling
            let error = NSError()
            throw error
        }
        return game
    }
}

// MARK: -- Usage Example

public class GenericGame {
        
    var game = Game()
    let gameSystem = GameSystem()
    
    private func startPlaying() {
        game.monstersEatPlayer()
        game.rackUpMassivePoints()
        
        // Save Game
        try! gameSystem.save(game, title: "My Fav Game")
        
        // Load game
        game = try! gameSystem.load("My Fav Game")
    }
    
}


