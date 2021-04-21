//
//  SettingsViewController.swift
//  Snatch a Million
//
//  Created by Alexander Fomin on 06.04.2021.
//

import UIKit

enum QuestionSequenceMode: Int {
    case serial, random
}

class SettingsViewController: UIViewController {
    @IBOutlet weak var questionSequenceSegmentedControl: UISegmentedControl!
    
    @IBAction func onQuestionsSequenceModeChanged(_ sender: UISegmentedControl) {
        Game.shared.questionSequenceMode = QuestionSequenceMode(rawValue: sender.selectedSegmentIndex) ?? .serial
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionSequenceSegmentedControl.selectedSegmentIndex =  Game.shared.questionSequenceMode.rawValue
    }
}
