//
//  Question.swift
//  Snatch a Million
//
//  Created by Alexander Fomin on 04.04.2021.
//

import Foundation

struct Question: Codable {
    var text: String
    var answers: [String]
    var correctAnswer: Int
}

extension Question {
    static let empty = Question(text: "", answers: ["","","",""], correctAnswer: 0)
}
