//
//  TaskViewModelTests.swift
//  ToDoLIstTests
//
//  Created by benedict on 24/10/25.
//

import XCTest

//final class TaskViewModelTests: XCTestCase {
//
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//
//}
//@testable import ToDoLIst

//final class TaskViewModelTests: XCTestCase {
//    var viewModel: TaskViewModel!
//
//    override func setUp() {
//        super.setUp()
//        viewModel = TaskViewModel()
//        viewModel.tasks = [] // start clean
//    }
//
//    override func tearDown() {
//        viewModel = nil
//        super.tearDown()
//    }
//
//    func testAddTask() {
//        // Arrange
//        XCTAssertEqual(viewModel.tasks.count, 0)
//
//        // Act
//        viewModel.addTask(
//            title: "Buy groceries",
//            description: "Milk, Eggs, Bread",
//            priority: .high,
//            dueDate: nil,
//            category: "Home"
//        )
//
//        // Assert
//        XCTAssertEqual(viewModel.tasks.count, 1)
//        XCTAssertEqual(viewModel.tasks.first?.title, "Buy groceries")
//        XCTAssertFalse(viewModel.tasks.first!.isCompleted)
//    }
//
//    func testToggleComplete() {
//        viewModel.addTask(
//            title: "Do laundry",
//            description: "",
//            priority: .medium,
//            dueDate: nil,
//            category: nil
//        )
//        guard let task = viewModel.tasks.first else {
//            XCTFail("Task not found")
//            return
//        }
//
//        viewModel.toggleComplete(task)
//        XCTAssertTrue(viewModel.tasks.first!.isCompleted)
//    }
//
//    func testDeleteTask() {
//        viewModel.addTask(
//            title: "Call mom",
//            description: "",
//            priority: .low,
//            dueDate: nil,
//            category: nil
//        )
//
//        let task = viewModel.tasks.first!
//        viewModel.deleteTask(task)
//
//        XCTAssertTrue(viewModel.tasks.isEmpty)
//    }
//
//    func testFiltering() {
//        viewModel.addTask(title: "Done", description: "", priority: .low, dueDate: nil, category: nil)
//        viewModel.addTask(title: "Pending", description: "", priority: .low, dueDate: nil, category: nil)
//        viewModel.tasks[0].isCompleted = true
//        
//        viewModel.filter = .completed
//        XCTAssertEqual(viewModel.filteredTasks.count, 1)
//        
//        viewModel.filter = .pending
//        XCTAssertEqual(viewModel.filteredTasks.count, 1)
//        
//        viewModel.filter = .all
//        XCTAssertEqual(viewModel.filteredTasks.count, 2)
//    }
//
//    func testSearchFiltering() {
//        viewModel.addTask(title: "Write report", description: "Quarterly", priority: .medium, dueDate: nil, category: nil)
//        viewModel.addTask(title: "Clean desk", description: "Office", priority: .low, dueDate: nil, category: nil)
//        
//        viewModel.searchText = "write"
//        XCTAssertEqual(viewModel.filteredTasks.count, 1)
//        XCTAssertEqual(viewModel.filteredTasks.first?.title, "Write report")
//    }
//}




@testable import ToDoLIst
@MainActor
final class TaskViewModelTests: XCTestCase {
    func testAddTask() async {
        let viewModel = TaskViewModel()
        viewModel.addTask(title: "Test", description: "Testing", priority: .high, dueDate: nil, category: "Work")
        XCTAssertEqual(viewModel.tasks.count, 1)
        XCTAssertEqual(viewModel.tasks.first?.title, "Test")
    }
}
