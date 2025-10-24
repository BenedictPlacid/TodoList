//
//  TaskListView.swift
//  ToDoLIst
//
//  Created by benedict on 24/10/25.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var viewModel: TaskViewModel
    @State private var showAddTask = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.filteredTasks.isEmpty {
                    EmptyStateView()
                } else {
                    List {
                        ForEach(viewModel.filteredTasks) { task in
                            TaskRowView(task: task)
                                .swipeActions {
                                    Button(role: .destructive) {
                                        viewModel.deleteTask(task)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                    
                                    Button {
                                        viewModel.toggleComplete(task)
                                    } label: {
                                        Label("Complete", systemImage: task.isCompleted ? "xmark" : "checkmark")
                                    }
                                }
                        }
                    }
                    .searchable(text: $viewModel.searchText)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showAddTask = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddTask) {
                AddEditTaskView()
            }
            .navigationTitle("Smart Todo")
        }
    }
    
}
