//
//  QuestionSequenceStrategy.swift
//  Snatch a Million
//
//  Created by Alexander Fomin on 07.04.2021.
//

import Foundation

protocol QuestionSequenceStrategy {
   mutating func getQuestionIndex() -> Int
}

struct SerialQuestionSequenceStrategy: QuestionSequenceStrategy {
    var questionIndex = 0
    
    mutating func getQuestionIndex() -> Int {
        questionIndex += 1
        return questionIndex
    }
}

struct RandomQuestionSequenceStrategy: QuestionSequenceStrategy {
    var questionsIndexes: [Int]
    
    init(questionsCount: Int) {
        self.questionsIndexes = Array(0..<questionsCount).shuffled()
    }
    
    mutating func getQuestionIndex() -> Int {
        let questionIndex = questionsIndexes.first ?? 0
        questionsIndexes.removeFirst()
        return questionIndex
    }
}
