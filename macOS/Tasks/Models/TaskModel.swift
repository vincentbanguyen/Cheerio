import Foundation

struct Task: Identifiable {
    var id = UUID().uuidString
    var title: String
    var completed: Bool
}

let testDataTasks = [
    Task(title: "test 1", completed: false),
    Task(title: "test 2", completed: false),
    Task(title: "test 3", completed: false),
    Task(title: "test 4", completed: false)
]
