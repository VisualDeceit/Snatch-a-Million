//
//  GameViewController.swift
//  Snatch a Million
//
//  Created by Alexander Fomin on 04.04.2021.
//

import UIKit

protocol GameViewControllerProtocol: AnyObject {
    func didSelectAnswer(_ controller: GameViewController, _ sender: UIButton)
}

class GameViewController: UIViewController {
    
    weak var delegate: GameViewControllerProtocol?
    
    @IBOutlet weak var answer0Button: UIButton!
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var questionLebel: UILabel!
    
    @IBAction func onAnswer0Pressed(_ sender: UIButton) {
        delegate?.didSelectAnswer(self, sender)
        showNextQuestion(Game.shared.getQuestion())
    }
    
    @IBAction func onAnswer1Pressed(_ sender: UIButton) {
        delegate?.didSelectAnswer(self, sender)
        showNextQuestion(Game.shared.getQuestion())
    }
    
    @IBAction func onAnswer2Pressed(_ sender: UIButton) {
        delegate?.didSelectAnswer(self, sender)
        showNextQuestion(Game.shared.getQuestion())
    }
    
    @IBAction func onAnswer3Pressed(_ sender: UIButton) {
        delegate?.didSelectAnswer(self, sender)
        showNextQuestion(Game.shared.getQuestion())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beginGame()
    }
    
    /// Начальная инициализация игры
    func beginGame() {
        
        let gameSession = GameSession()
        self.delegate = gameSession
        Game.shared.setSession(session: gameSession)

        showNextQuestion(Game.shared.getQuestion())
    }
    
    func showNextQuestion(_ question: Question?) {
        guard let question =  question else {
            return
        }
        questionLebel.text = question.text
        answer0Button.setTitle(question.answers[0], for: .normal)
        answer1Button.setTitle(question.answers[1], for: .normal)
        answer2Button.setTitle(question.answers[2], for: .normal)
        answer3Button.setTitle(question.answers[3], for: .normal)

    }
    
    
}
