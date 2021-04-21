//
//  QuestionsBuilder.swift
//  Snatch a Million
//
//  Created by Alexander Fomin on 09.04.2021.
//

import Foundation

class QuestionsBuilder {
    
    private var currentQuestion: Question?
    private var questions: [Question] = []
   
    func addQuestion() {
        guard let question = currentQuestion,
              !question.text.isEmpty,
              !question.answers[0].isEmpty,
              !question.answers[1].isEmpty,
              !question.answers[2].isEmpty,
              !question.answers[3].isEmpty else {
            currentQuestion = .empty
            return
        }
        self.questions.append(question)
        currentQuestion = .empty
    }
    
    func build() -> [Question] {
        return questions
    }
    
    func setQuestion(_ text: String) {
        self.currentQuestion?.text = text
    }
    
    func setAnswer(_ index: Int, _ answer: String) {
        self.currentQuestion?.answers[index] = answer
    }
    
    func setCorrectAnswer(_ index: Int) {
        self.currentQuestion?.correctAnswer = index
    }
}
