//
//  Task.swift
//  ios-tasks-app-3
//
//  Created by 김다은 on 2022/03/19.
//

import Foundation
import FirebaseFirestoreSwift

struct Task: Identifiable, Codable {
    @DocumentID var id: String?
    @ServerTimestamp var createdAt: Date?
    let title: String
    var isDone: Bool = false
    var doneAt: Date?
}
