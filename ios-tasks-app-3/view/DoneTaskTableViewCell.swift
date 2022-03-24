//
//  DoneTaskTableViewCell.swift
//  ios-tasks-app-3
//
//  Created by 김다은 on 2022/03/23.
//

import UIKit

class DoneTaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with task: Task) {
        titleLabel.text = task.title
    }
}
