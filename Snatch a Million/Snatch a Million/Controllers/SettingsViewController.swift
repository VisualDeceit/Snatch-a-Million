//
//  SettingsViewController.swift
//  Snatch a Million
//
//  Created by Alexander Fomin on 06.04.2021.
//

import UIKit

class SettingsViewController: UIViewController {
 
    @IBAction func onQuestionsSequenceModeChanged(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
    }
}
