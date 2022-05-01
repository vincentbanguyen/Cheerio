import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskListVM = TaskListViewModel()
    
  
    @State var text = ""
    @State var addNewTask = false
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Add a task", text: $text, onCommit: onCommit)
            List {
                ForEach(taskListVM.taskCellViewModels) { taskCellVM in
                    TaskCell(taskCellVM: taskCellVM, taskListVM: taskListVM)
                }
            }
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
    static var previews: some View {
        TaskListView()
    }
}


struct TaskCell: View {
    @ObservedObject var taskCellVM: TaskCellViewModel
    @ObservedObject var taskListVM: TaskListViewModel
    var onCommit: (Task) -> (Void) = { _ in }
    var body: some View {
        HStack {
            Image(systemName: "smallcircle.fill.circle.fill")
                .foregroundColor(.yellow)
                .onTapGesture {
                    print("attempt to delete")
                    taskListVM.deleteTask(task: taskCellVM.task)
                    taskListVM.fetchTasks()
                    
                }
            TextField("Edit Task", text: $taskCellVM.task.title, onCommit: {
                self.onCommit(self.taskCellVM.task) // when commit, update task
            })
        }
        
    }
}
