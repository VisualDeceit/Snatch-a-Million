//
//  CustomQuestionTableViewCell.swift
//  Snatch a Million
//
//  Created by Alexander Fomin on 09.04.2021.
//

import UIKit

class CustomQuestionTableViewCell: UITableViewCell {

    private var questionsBuilder: QuestionsBuilder!
    
    @IBOutlet weak var questionTextView: UITextView!    
    @IBOutlet var answerCorrectSwitches: [UISwitch]!
    @IBOutlet var answerTextFeilds: [UITextField]!

    @IBAction func didTougleSwith(_ sender: UISwitch) {
        questionsBuilder.setCorrectAnswer(sender.tag)
        answerCorrectSwitches.forEach {
            if $0.tag != sender.tag {
                $0.isOn = false
            }
        }
    }
    
    func configure(question: Question, builder: QuestionsBuilder) {
        questionsBuilder = builder
        questionTextView.text = question.text
        
        for i in 0..<answerTextFeilds.count {
            answerTextFeilds[i].text = question.answers[i]
        }
        
        answerCorrectSwitches.forEach {
            $0.isOn = $0.tag == question.correctAnswer ? true : false
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
