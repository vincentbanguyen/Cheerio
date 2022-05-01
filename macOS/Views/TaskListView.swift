import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskListVM = TaskListViewModel()
    @Binding var completedTask: Bool
    @State var text = ""
    @State var addNewTask = false
    var body: some View {
       
        VStack(alignment: .leading, spacing: 10) {
                TextField("Add a task", text: $text, onCommit: onCommit)
                List {
                    ForEach(taskListVM.taskCellViewModels) { taskCellVM in
                        TaskCell(taskCellVM: taskCellVM, taskListVM: taskListVM, completedTask: $completedTask)
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

struct TaskListView_Previews: PreviewProvider {
    @State static var completedTask = false
    static var previews: some View {
        TaskListView(completedTask: $completedTask)
    }
}


struct TaskCell: View {
    
    @ObservedObject var taskCellVM: TaskCellViewModel
    @ObservedObject var taskListVM: TaskListViewModel
    @Binding var completedTask: Bool
    
    var onCommit: (Task) -> (Void) = { _ in }
    var body: some View {
        HStack {
            Image(systemName: "smallcircle.fill.circle.fill")
                .foregroundColor(.yellow)
                .onTapGesture {
                    print("attempt to delete")
                    taskListVM.deleteTask(task: taskCellVM.task)
                    taskListVM.fetchTasks()
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
