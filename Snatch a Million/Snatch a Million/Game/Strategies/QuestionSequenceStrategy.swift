//
//  QuestionSequenceStrategy.swift
//  Snatch a Million
//
//  Created by Alexander Fomin on 07.04.2021.
//

import Foundation

protocol QuestionSequenceStrategy {
    func apply(collection: [Question]) -> [Question]
}

struct SerialQuestionSequenceStrategy: QuestionSequenceStrategy {
    func apply(collection: [Question]) -> [Question] {
        collection
    }
}

struct RandomQuestionSequenceStrategy: QuestionSequenceStrategy {
    func apply(collection: [Question]) -> [Question] {
        collection.shuffled()
    }
}
