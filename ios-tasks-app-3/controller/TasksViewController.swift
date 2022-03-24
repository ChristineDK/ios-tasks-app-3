//
//  ViewController.swift
//  ios-tasks-app-3
//
//  Created by 김다은 on 2022/03/17.
//

import UIKit

class TasksViewController: UIViewController {

    @IBOutlet weak var menuSegmentedControl: UISegmentedControl!
    @IBOutlet weak var ongoingTasksContainerView: UIView!
    @IBOutlet weak var doneTasksContainerView: UIView!
    
    private let databaseManager = DatabaseManger()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentedControl()
        
    ongoingTasksContainerView.isHidden = false
    doneTasksContainerView.isHidden = true
    }
    
    private func setupSegmentedControl() {
        menuSegmentedControl.removeAllSegments()
        MenuSection.allCases.enumerated().forEach { (index, section) in
            menuSegmentedControl.insertSegment(withTitle: section.rawValue, at: index, animated: false)
        }
        menuSegmentedControl.selectedSegmentIndex = 0
        showContainerView(for: .ongoing)
    }
    
    @IBAction func segmentedControlChanged(_ sender:
                                            UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            showContainerView(for: .ongoing)
        case 1:
            showContainerView(for: .done)
        default: break
        }
    }
    
    private func showContainerView(for section: MenuSection) {
        switch section {
        case .ongoing:
            ongoingTasksContainerView.isHidden = false
            doneTasksContainerView.isHidden = true
        case .done:
            ongoingTasksContainerView.isHidden = true
            doneTasksContainerView.isHidden = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNewTask",
           let destination = segue.destination as? NewTaskViewController {
            destination.delegate = self
        }
        
    }
    
    @IBAction func addTaskButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "showNewTask", sender: nil)
    }

}

extension TasksViewController: TasksVCDelegate {
    
    func didAddTask(_ task: Task) {
        presentedViewController?.dismiss(animated: true, completion: {  [unowned self] in
            self.databaseManager.addTask(task) { (result) in
                switch result {
                case .success:
                    print("yay")
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                }
            }
        })
    }
}

