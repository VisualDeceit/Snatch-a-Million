//
//  CustomQuestionTableViewCell.swift
//  Snatch a Million
//
//  Created by Alexander Fomin on 09.04.2021.
//

import UIKit

class CustomQuestionTableViewCell: UITableViewCell {

    private var questionsBuilder: QuestionsBuilder!
    private var groupSwitches = [UISwitch]()
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answer1TextField: UITextField!
    @IBOutlet weak var answer2TextField: UITextField!
    @IBOutlet weak var answer3TextField: UITextField!
    @IBOutlet weak var answer4TextField: UITextField!
    @IBOutlet weak var answer1IsCorrectSwitch: UISwitch!
    @IBOutlet weak var answer2IsCorrectSwitch: UISwitch!
    @IBOutlet weak var answer3IsCorrectSwitch: UISwitch!
    @IBOutlet weak var answer4IsCorrectSwitch: UISwitch!
    
    @IBAction func didTougleSwith(_ sender: UISwitch) {
        questionsBuilder.setCorrectAnswer(sender.tag)
        groupSwitches.forEach {
            if $0.tag != sender.tag {
                $0.isOn = false
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        questionTextView.delegate = self
        answer1TextField.delegate = self
        answer2TextField.delegate = self
        answer3TextField.delegate = self
        answer4TextField.delegate = self
        
        groupSwitches = [answer1IsCorrectSwitch] + [answer2IsCorrectSwitch] + [answer3IsCorrectSwitch] + [answer4IsCorrectSwitch]
    }
    
    func populate(question: Question, builder: QuestionsBuilder) {
        questionsBuilder = builder
        
        questionTextView.text = question.text
        answer1TextField.text = question.answers[0]
        answer2TextField.text = question.answers[1]
        answer3TextField.text = question.answers[2]
        answer4TextField.text = question.answers[3]
        
        groupSwitches.forEach {
            $0.isOn = $0.tag ==  question.correctAnswer ? true : false
        }
    }
}

extension CustomQuestionTableViewCell: UITextViewDelegate, UITextFieldDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        questionsBuilder.setText(textView.text)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        questionsBuilder.setAnswer(textField.tag, textField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return true
        }
        return true
    }
}
