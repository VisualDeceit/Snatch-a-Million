//
//  QuestionsBuilder.swift
//  Snatch a Million
//
//  Created by Alexander Fomin on 09.04.2021.
//

import Foundation

class QuestionsBuilder {
    
    private var currentQuestion = Question(text: "", answers: ["","","",""], correctAnswer: 0)
    private var questions: [Question] = []
   
    func addQuestion() -> Question {
        self.questions.append(currentQuestion)
        let result = currentQuestion
        currentQuestion = reset()
        return result
    }
    
    func reset() ->  Question {
        Question(text: "", answers: ["","","",""], correctAnswer: 0)
    }
    
    func getQuestions() -> [Question] {
        return questions
    }
    
    func setText(_ text: String) {
        self.currentQuestion.text = text
    }
    
    func setAnswer(_ index: Int, _ answer: String) {
        self.currentQuestion.answers[index] = answer
    }
    
    func setCorrectAnswer(_ index: Int) {
        self.currentQuestion.correctAnswer = index
    }
}
