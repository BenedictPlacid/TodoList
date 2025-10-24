//
//  TaskStorage.swift
//  ToDoLIst
//
//  Created by benedict on 24/10/25.
//

import Foundation

actor TaskStorage {
    private let filename = "tasks.json"
    
    private var fileURL: URL {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return directory.appendingPathComponent(filename)
    }
    
    func save(_ tasks: [TaskModel]) async throws {
        let data = try JSONEncoder().encode(tasks)
        try data.write(to: fileURL)
    }
    
    func load() async throws -> [TaskModel]? {
        guard FileManager.default.fileExists(atPath: fileURL.path) else { return [] }
        let data = try Data(contentsOf: fileURL)
        return try JSONDecoder().decode([TaskModel].self, from: data)
    }
}

