//
//  OngoingTasksTableViewController.swift
//  ios-tasks-app-3
//
//  Created by 김다은 on 2022/03/17.
//

import UIKit

class OngoingTasksTableViewController: UITableViewController {
    
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
        
        databaseManger.addTasksListener(forDoneTasks: false) { [weak self] (result) in
            switch result {
            case .success(let tasks):
                self?.tasks = tasks
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func handleActionButton(for task: Task) {
        guard let id = task.id else {return}
        databaseManger.updateTaskToDone(id: id) { (result) in
            switch result {
            case .success:
                print("set to done successfully")
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension OngoingTasksTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! OngoingTaskTableViewCell
        let task=tasks[indexPath.row]
        cell.actionButtonDidTap = { [weak self] in
            self?.handleActionButton(for: task)
        }
        cell.configure(with: task)
        return cell
    }
    
}
