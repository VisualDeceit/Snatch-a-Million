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
    var user: String = "None"
    var questionSequenceMode: QuestionSequenceMode = .serial
    
    private(set) var results: [Result] = []
    private(set) var customQuestions: [Question] = []
    
    let resultsCareTaker = OriginalCareTaker(key: UserDefaultsKeys.results)
    let questionsCareTaker = OriginalCareTaker(key: UserDefaultsKeys.questions)
    
    func addResult(_ result: Result) {
        self.results.append(result)
        resultsCareTaker.save(results)
    }
    
    func addQuestions(_ questions: [Question]) {
        self.customQuestions.append(contentsOf: questions)
        questionsCareTaker.save(customQuestions)
    }
    
    private init() {
        self.results = resultsCareTaker.load()
        self.customQuestions = questionsCareTaker.load()
    }
}
