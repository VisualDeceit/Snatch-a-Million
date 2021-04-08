//
//  GameSession.swift
//  Snatch a Million
//
//  Created by Alexander Fomin on 04.04.2021.
//

import UIKit

class GameSession {
    
   private let allQuestions: [Question] = {
        var q = [Question]()
        q.append(Question(text: "Что в Российской империи было вещевым эквивалентом денег?",
                          answers: ["Шкуры пушных зверей", "Крупный рогатый скот", "Табак", "Женские серьги"],
                          correctAnswer: 0))
        q.append(Question(text: "У индейцев из немногочисленного североамериканского племени квакиутл есть традиция: беря деньги в долг, они оставляют в залог…",
                          answers: ["Душу", "Имя", "Скальп тещи", "Амулет"],
                          correctAnswer: 1))
        q.append(Question(text: "Российский мультфильм, удостоенный «Оскара», — это…",
                          answers: ["«Простоквашино»","«Винни-Пух»","«Старик и море»","«Ну, погоди!»"],
                          correctAnswer: 2))
        q.append(Question(text: "Кто из знаменитых художников за жизнь продал всего одну картину?",
                          answers: ["Винсент Ван Гог","Пьер Огюст Ренуар","Поль Гоген","Клод Моне"],
                          correctAnswer: 0))
        q.append(Question(text: "Туристы, приезжающие на Майорку, обязаны заплатить налог…",
                          answers: ["На плавки","На пальмы","На солнце","На жену"],
                          correctAnswer: 2))
        return q
    }()
    
    var questionSequenceStrategy: QuestionSequenceStrategy
    
    private var currentQuestionIndex: Int = 0
    
    var question: Question {
        return allQuestions[currentQuestionIndex]
    }
    
    private var correctAnswers = 0
    
    init() {
        switch Game.shared.questionSequenceMode {
        case .serial:
            questionSequenceStrategy =  SerialQuestionSequenceStrategy()
        case .random:
            questionSequenceStrategy =  RandomQuestionSequenceStrategy(questionsCount: allQuestions.count)
            currentQuestionIndex = questionSequenceStrategy.getQuestionIndex()
        }
    }
}



extension GameSession: GameViewControllerDelegate {
    
    func didSelectAnswer(_ controller: GameViewController, _ sender: UIButton) {
        if sender.tag == question.correctAnswer {
            //верный ответ
            correctAnswers += 1
        } else {
            //проиграли
            endGame(controller)
            return
        }
        
        if correctAnswers == allQuestions.count {
            //конец  игры
            endGame(controller)
            return
        }
        currentQuestionIndex = questionSequenceStrategy.getQuestionIndex()
    }
    
    func endGame(_ controller: GameViewController) {
        let progress = Double(correctAnswers) / Double(allQuestions.count) * 100.0
        Game.shared.addResult(Result(user: Game.shared.user, progress: progress))
        Game.shared.gameSession = nil
        controller.dismiss(animated: true)
    }
}
