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
    var questionsCount: Int
    var questionIndex = 0
    
    mutating func getQuestionIndex() -> Int {
        if questionIndex < questionsCount - 1 {
            questionIndex += 1
        }
        return questionIndex
    }
}

struct RandomQuestionSequenceStrategy: QuestionSequenceStrategy {
    var questionsCount: Int
    var questionsAsked: [Int] = []
    
    mutating func getQuestionIndex() -> Int {
        if questionsAsked.isEmpty {
            questionsAsked = Array(0..<questionsCount).shuffled()
        }
        
        let questionIndex = questionsAsked.first ?? 0
        questionsAsked.removeFirst()

        return questionIndex
    }
}
