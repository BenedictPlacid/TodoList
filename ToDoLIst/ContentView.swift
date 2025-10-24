//
//  ContentView.swift
//  ToDoLIst
//
//  Created by benedict on 24/10/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = TaskViewModel()
    var body: some View {
        TaskListView()
            .environmentObject(viewModel)
    }
}

#Preview {
   ContentView()
}
