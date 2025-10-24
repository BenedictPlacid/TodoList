//
//  Models.swift
//  ToDoLIst
//
//  Created by benedict on 24/10/25.
//

import Foundation

enum Priority: String, Codable, CaseIterable {
    case high, medium, low
    
    var color: String {
        switch self {
        case .high: return "red"
        case .medium: return "orange"
        case .low: return "green"
        }
    }
}

struct TaskModel: Identifiable, Codable {
    let id: UUID
    var title: String
    var description: String
    var isCompleted: Bool
    var priority: Priority
    var dueDate: Date?
    var category: String?
    let createdAt: Date
    
    var isOverdue: Bool {
        if let due = dueDate {
            return !isCompleted && due < Date()
        }
        return false
    }
}
