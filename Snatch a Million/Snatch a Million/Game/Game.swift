//
//  Game.swift
//  Snatch a Million
//
//  Created by Alexander Fomin on 04.04.2021.
//

import Foundation

struct Result: Codable {
    let user: String
    let date: Date
    let progress: Int
    let correct: Int
}

class Game {
    static var shared = Game()
    
    private var gameSession: GameSession?
    
    private(set) var results: [Result] = []
    
    var user: String = "None"
    
    let resultsCareTaker = ResulsCareTaker()
    
    func setSession(session: GameSession){
        gameSession = session
    }
    
    func getQuestion() -> Question? {
        return gameSession?.question
    }
    
    func clearSession() {
        gameSession = nil
    }
    
    func addResult(_ result: Result) {
        self.results.append(result)
        resultsCareTaker.save(results)
    }
    
    private init() {
        self.results = resultsCareTaker.load()
    }
}
