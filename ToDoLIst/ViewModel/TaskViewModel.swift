//
//  TaskViewModel.swift
//  ToDoLIst
//
//  Created by benedict on 24/10/25.
//

import SwiftUI

@MainActor
class TaskViewModel: ObservableObject {
    @Published var tasks: [TaskModel] = []
    @Published var searchText = ""
    @Published var filter: TaskFilter = .all
    
    private let storage = TaskStorage()
    
    enum TaskFilter { case all, pending, completed }
    
    init() {
        loadTasks()
    }
    
    func addTask(title: String, description: String, priority: Priority, dueDate: Date?, category: String?) {
        let newTask = TaskModel(
            id: UUID(),
            title: title,
            description: description,
            isCompleted: false,
            priority: priority,
            dueDate: dueDate,
            category: category,
            createdAt: Date()
        )
        tasks.append(newTask)
        saveTasks()
    }
    
    func updateTask(_ task: TaskModel) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
            saveTasks()
        }
    }
    
    func deleteTask(_ task: TaskModel) {
        tasks.removeAll { $0.id == task.id }
        saveTasks()
    }
    
    func toggleComplete(_ task: TaskModel) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
            saveTasks()
        }
    }
    
    var filteredTasks: [TaskModel] {
        tasks
            .filter {
                switch filter {
                case .all: return true
                case .pending: return !$0.isCompleted
                case .completed: return $0.isCompleted
                }
            }
            .filter {
                searchText.isEmpty ||
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.description.localizedCaseInsensitiveContains(searchText)
            }
            .sorted(by: { $0.createdAt > $1.createdAt })
    }
    
    func saveTasks() {
        Task {
            try? await storage.save(tasks)
        }
    }
    
    func loadTasks() {
        Task {
            if let loaded = try? await storage.load() {
                self.tasks = loaded
            }
        }
    }
}

