//
//  OngoingTaskTableViewCell.swift
//  ios-tasks-app-3
//
//  Created by 김다은 on 2022/03/19.
//

import UIKit

class OngoingTaskTableViewCell: UITableViewCell {
    
    var actionButtonDidTap: (() -> Void)?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    
    func configure(with task: Task) {
        titleLabel.text = task.title
    }
    
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        actionButtonDidTap?()
    }
}
