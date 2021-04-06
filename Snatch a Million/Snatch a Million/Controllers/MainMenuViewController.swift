//
//  MainMenuViewController.swift
//  Snatch a Million
//
//  Created by Alexander Fomin on 04.04.2021.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBAction func unwindToMainMenu(_ unwindSegue: UIStoryboardSegue) {}
    
    @IBAction func onbeginGamePressed (_ sender: UIButton){
        let alert = UIAlertController(title: "Введите имя игрока", message: "", preferredStyle: .alert)
        alert.addTextField()
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            Game.shared.user =  "\(alert.textFields?.first?.text ?? "None")"
            self.performSegue(withIdentifier: "beginGameSegue", sender: nil)
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
