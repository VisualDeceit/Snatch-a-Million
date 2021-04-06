//
//  Game.swift
//  Snatch a Million
//
//  Created by Alexander Fomin on 04.04.2021.
//

import Foundation

struct Result: Codable {
    let user: String
    let progress: Double
}

class Game {
    static var shared = Game()
    
    var gameSession: GameSession?
    
    private(set) var results: [Result] = []
    
    var user: String = "None"
    
    let resultsCareTaker = ResultsCareTaker()
    
    func addResult(_ result: Result) {
        self.results.append(result)
        resultsCareTaker.save(results)
    }
    
    private init() {
        self.results = resultsCareTaker.load()
    }
}
