//
//  ViewExtansion.swift
//  ToDoLIst
//
//  Created by benedict on 24/10/25.
//

import SwiftUI

struct TaskRowView: View {
    @EnvironmentObject var viewModel: TaskViewModel
    var task: TaskModel
    
    var body: some View {
        HStack {
            Circle()
                .fill(Color(task.priority.color))
                .frame(width: 10, height: 10)
            
            VStack(alignment: .leading) {
                Text(task.title)
                    .strikethrough(task.isCompleted)
                    .font(.headline)
                Text(task.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                if let due = task.dueDate {
                    Text("Due: \(due.formatted(date: .numeric, time: .omitted))")
                        .font(.caption)
                        .foregroundColor(task.isOverdue ? .red : .gray)
                }
            }
            Spacer()
        }
    }
}

struct AddEditTaskView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: TaskViewModel
    @State private var title = ""
    @State private var description = ""
    @State private var priority = Priority.medium
    @State private var dueDate: Date? = nil
    @State private var category = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Details") {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                }
                Section("Options") {
                    Picker("Priority", selection: $priority) {
                        ForEach(Priority.allCases, id: \.self) {
                            Text($0.rawValue.capitalized)
                        }
                    }
                    DatePicker("Due Date",selection: Binding(get: { dueDate ?? Date() },set: { dueDate = $0 }),displayedComponents: .date)
                    TextField("Category", text: $category)
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        guard !title.isEmpty else { return }
                        viewModel.addTask(
                            title: title,
                            description: description,
                            priority: priority,
                            dueDate: dueDate,
                            category: category
                        )
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
            .navigationTitle("New Task")
        }
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "tray")
                .font(.system(size: 50))
                .foregroundColor(.gray)
            Text("No tasks yet!")
                .font(.headline)
            Text("Tap the + button to add your first task.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}
