import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskListVM = TaskListViewModel()
    
    let tasks = testDataTasks // for testing/debugging
    @State var text = ""
    @State var addNewTask = false
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Add a task", text: $text, onCommit: onCommit)
            List {
                ForEach(taskListVM.taskCellViewModels) { taskCellVM in
                    if taskCellVM.task.completed == false {
                        TaskCell(taskCellVM: taskCellVM)
                    }
                }
            }
        }
    }
    func onCommit() -> Void {
        print("commited")
        
        addNewTask.toggle()
        self.taskListVM.addTask(task: Task(title: text, completed: false))
        text = ""
      }
    
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}


struct TaskCell: View {
    @ObservedObject var taskCellVM: TaskCellViewModel
    var onCommit: (Task) -> (Void) = { _ in }
    var body: some View {
        HStack {
            Image(systemName: "smallcircle.fill.circle.fill")
                .foregroundColor(.yellow)
            TextField("Edit Task", text: $taskCellVM.task.title, onCommit: {
                self.onCommit(self.taskCellVM.task) // when commit, update task
            })
        }
        .onTapGesture {
            self.taskCellVM.task.completed = true
            print("removing task")
        }
    }
}
