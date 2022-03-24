//
//  TasksVCDelegate.swift
//  ios-tasks-app-3
//
//  Created by 김다은 on 2022/03/19.
//

import Foundation

protocol TasksVCDelegate: class {
    func didAddTask(_ task: Task)
}
