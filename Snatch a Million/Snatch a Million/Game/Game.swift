//
//  Game.swift
//  Snatch a Million
//
//  Created by Alexander Fomin on 04.04.2021.
//

import Foundation

class Game {
    static var shared = Game()
    
    private var gameSession: GameSession?
    
    func setSession(session: GameSession){
        gameSession = session
    }
    
    func getQuestion() -> Question? {
        return gameSession?.question
    }
    
    func clearSession() {
        gameSession = nil
    }
    
    private init() {}
}
