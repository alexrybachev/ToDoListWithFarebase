//
//  TasksViewController.swift
//  ToDoListWithFarebase
//
//  Created by Aleksandr Rybachev on 03.06.2022.
//

import UIKit

class TasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = "This is cell number \(indexPath.row)"
        cell.contentConfiguration = content
        return cell
    }

    @IBAction func addTapped(_ sender: UIBarButtonItem) {
    }
}
