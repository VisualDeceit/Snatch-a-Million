//
//  GameViewController.swift
//  Snatch a Million
//
//  Created by Alexander Fomin on 04.04.2021.
//

import UIKit

protocol GameViewControllerDelegate: AnyObject {
    func didSelectAnswer(_ controller: GameViewController, _ sender: UIButton)
}

class GameViewController: UIViewController {
    
    weak var delegate: GameViewControllerDelegate?
    
    @IBOutlet weak var answer0Button: UIButton!
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var questionLebel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBAction func onAnswerButtonPressed(_ sender: UIButton) {
        delegate?.didSelectAnswer(self, sender)
        showNextQuestion(Game.shared.gameSession?.question)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginGame()
    }
    
    /// Начальная инициализация игры
    func beginGame() {
        let gameSession = GameSession()
        self.delegate = gameSession
        Game.shared.gameSession = gameSession
        showNextQuestion(Game.shared.gameSession?.question)
    }
    
    func showNextQuestion( _ question: Question?) {
        guard let question =  question else { return }
        questionLebel.text = question.text
        answer0Button.setTitle(question.answers[0], for: .normal)
        answer1Button.setTitle(question.answers[1], for: .normal)
        answer2Button.setTitle(question.answers[2], for: .normal)
        answer3Button.setTitle(question.answers[3], for: .normal)
    }
}
