import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskListVM = TaskListViewModel()
    @Binding var completedTask: Bool
    @State var text = ""
    @State var addNewTask = false
    @Binding var completedTasks: String
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            HStack {
            TextField("Add a task", text: $text, onCommit: onCommit)
                Image(systemName: "arrow.clockwise")
                    .font(.system(size: 15, weight: .semibold))
                    .onTapGesture {
                        taskListVM.fetchTasks()
                    }
            }
            List {
                ForEach(taskListVM.taskCellViewModels) { taskCellVM in
                    TaskCell(taskCellVM: taskCellVM, taskListVM: taskListVM, completedTasks: $completedTasks, completedTask: $completedTask)
                        .foregroundColor(completedTask ? .gray : .white)
                }
            }
            .cornerRadius(20)
        }
    }
    
    func onCommit() -> Void {
        if !text.isEmpty {
            print("adding tasK: \(text)")
            NSApplication.shared.sendAction(#selector(NSResponder.resignFirstResponder), to: nil, from: nil)
            addNewTask.toggle()
            self.taskListVM.addTask(task: Task(title: text, completed: "false"))
            text = ""
        }
    }
    
}

struct TaskCell: View {
    
    @ObservedObject var taskCellVM: TaskCellViewModel
    @ObservedObject var taskListVM: TaskListViewModel
    @Binding var completedTasks: String
    @Binding var completedTask: Bool
    
    var onCommit: (Task) -> (Void) = { _ in }
    var body: some View {
        HStack {
            Image(systemName: completedTask ? "smallcircle.fill.circle.fill" : "circle")
                .foregroundColor(completedTask ? .yellow : .white)
                .onTapGesture {
                    print("removing task")
                    taskListVM.deleteTask(task: taskCellVM.task)
                    let storedCompletedTasks = keyValStore.string(forKey: "completedTasks") ?? "0"
                   
                    let newNum = Int(storedCompletedTasks)! + 1
                    keyValStore.set(String(newNum), forKey: "completedTasks")
                    completedTasks = String(newNum)
                    print("num completed tasks: \(completedTasks)")
                    keyValStore.synchronize()
                    completedTask = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        completedTask = false
                    }
                }
            TextField("Edit Task", text: $taskCellVM.task.title, onCommit: {
                self.onCommit(self.taskCellVM.task) // when commit, update task
            })
            .font(.system(size: 15, weight: .medium, design: .rounded))
        }
    }
}
