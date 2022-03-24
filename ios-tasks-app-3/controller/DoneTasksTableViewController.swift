//
//  DoneTasksTableViewController.swift
//  ios-tasks-app-3
//
//  Created by 김다은 on 2022/03/23.
//

import UIKit

class DoneTasksTableViewController: UITableViewController {
    
    private let databaseManger = DatabaseManger()
    
    private var tasks: [Task] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTasksListener()
    }
    
    private func addTasksListener() {
        
        databaseManger.addTasksListener(forDoneTasks: true) { [weak self] (result) in
            switch result {
            case .success(let tasks):
                self?.tasks = tasks
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension DoneTasksTableViewController {
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tasks.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! DoneTaskTableViewCell
        let task = tasks[indexPath.item]
        cell.configure(with: task)
        return cell
    }
}
