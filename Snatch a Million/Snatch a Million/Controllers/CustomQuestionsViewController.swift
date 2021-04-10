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
    
    @IBAction func onAddNewQuestionPreessed(_ sender: UIButton) {
        customQuestions.insert(questionsBuilder.addQuestion(), at: customQuestions.count - 1)
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: customQuestions.count - 1, section: 0), at: .bottom, animated: true)
    }
    
    @IBAction func onSaveAllQuestionPreessed(_ sender: UIButton) {
        print(questionsBuilder.getQuestions())
    }
    
//MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        // первый пустой вопрос
        customQuestions = [questionsBuilder.reset()]
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
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
        cell.questionsBuilder = self.questionsBuilder
        cell.question = customQuestions[indexPath.row]
        return cell
    }
}
