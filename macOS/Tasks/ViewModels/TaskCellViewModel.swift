import Foundation
import Combine

class TaskCellViewModel: ObservableObject, Identifiable {
    @Published var task: Task
//    var recordId = ""
//    private var cancellables = Set<AnyCancellable>()
    
    init(task: Task) {
        self.task = task
        
//        // keep track of id
//        $task
//            .map { task in // transforms task into string
//                task.recordId
//            }
//            .assign(to: \.recordId, on: self) // store value to var id
//            .store(in: &cancellables) // keep tracks using Combine subscribers
    }
}
