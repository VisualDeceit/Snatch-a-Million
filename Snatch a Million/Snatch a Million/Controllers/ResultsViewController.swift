//
//  ResultsViewController.swift
//  Snatch a Million
//
//  Created by Alexander Fomin on 04.04.2021.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var  tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
    }
}

extension ResultsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Game.shared.results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        let result = Game.shared.results[indexPath.row]
        cell.textLabel?.text = "\(result.user)"
        cell.detailTextLabel?.text = String(format: "%.0f%%", result.progress)
        return cell
    }
}
