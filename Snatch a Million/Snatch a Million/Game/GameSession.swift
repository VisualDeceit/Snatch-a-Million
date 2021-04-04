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
    
    private var currentQuestionIndex: Int = 0
    
    var question: Question {
        return allQuestions[currentQuestionIndex]
    }
    
    private var correctAnswers = 0
}



extension GameSession: GameViewControllerProtocol {
    
    func didSelectAnswer(_ controller: GameViewController, _ sender: UIButton) {
        //верный ответ
        if sender.tag == question.correctAnswer {
            correctAnswers += 1
        }
                
        if currentQuestionIndex < allQuestions.count - 1 {
            currentQuestionIndex += 1
        } else {
            //конец игры
            Game.shared.addResult(Result(user: Game.shared.user,
                                         date: Date(),
                                         progress: currentQuestionIndex + 1,
                                         correct: correctAnswers))
            Game.shared.clearSession()
            controller.dismiss(animated: true)
        }
    }
}
