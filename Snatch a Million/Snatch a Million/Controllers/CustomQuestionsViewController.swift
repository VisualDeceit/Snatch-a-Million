//
//  CustomQuestionsViewController.swift.swift
//  Snatch a Million
//
//  Created by Alexander Fomin on 09.04.2021.
//

import UIKit

class CustomQuestionsViewController: UIViewController {

    var customQuestions = [Question]()
    var questionsBuilder = QuestionsBuilder()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addQuestionBarButton: UIBarButtonItem!
    
    @IBAction func onAddNewQuestionPreessed(_ sender: UIButton) {
        questionsBuilder.addQuestion()
        customQuestions = questionsBuilder.getQuestions() + [questionsBuilder.reset()]
        
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: customQuestions.count - 1, section: 0), at: .bottom, animated: true)
        
        if customQuestions.count > 1 {
            addQuestionBarButton.isEnabled = true
        }
    }
    
    @IBAction func onAddAllQuestionsPressed(_ sender: UIButton) {
        Game.shared.addQuestions(questionsBuilder.getQuestions())
        dismiss(animated: true)
    }
    
//MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        customQuestions = [questionsBuilder.reset()]
        questionsBuilder.addQuestion()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
//MARK:- NotificationCenter
    @objc func keyboardWillShow(_ notification:Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}

//MARK: - DataSource
extension CustomQuestionsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        customQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath) as? CustomQuestionTableViewCell
        else { return CustomQuestionTableViewCell()}
        cell.configure(question: self.customQuestions[indexPath.row], builder: questionsBuilder)
        return cell
    }
}
