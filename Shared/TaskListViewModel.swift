import Foundation
import Combine
import CloudKit

class TaskListViewModel: ObservableObject {
    @Published var taskCellViewModels = [TaskCellViewModel]()
    private let database =  CKContainer(identifier: "iCloud.com.Ravinlabsdev.Cheerio").publicCloudDatabase
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchTasks()
    }
    
    func deleteTask(task: Task) {
        database.delete(withRecordID: task.recordId!) { [self] recordID, error in
            fetchTasks()
          
        }
    }
    func fetchTasks() {
        
        let query = CKQuery(recordType: "TaskItem",
                             predicate: NSPredicate(value: true))
        database.perform(query, inZoneWith: nil) { [weak self] records, error in
            guard let records = records, error == nil else {
                print(error?.localizedDescription)
                return
            }
            
            DispatchQueue.main.async {
                self?.taskCellViewModels = []
            }
            
            for task in records {
               
                let title = task.value(forKey: "title") as? String
                let completed = task.value(forKey: "completed") as? String
               
               
                let task = Task(recordId: task.recordID, title: title!, completed: completed!)
    
                let taskVM = TaskCellViewModel(task: task)
                DispatchQueue.main.async {
                    self?.taskCellViewModels.append(taskVM)
                }
            }
        }
    }
    
    
    func addTask(task: Task) {
        let taskVM = TaskCellViewModel(task: task)
        let record = CKRecord(recordType: "TaskItem")
        record.setValue("false", forKey: "completed")
        record.setValue(task.title, forKey: "title")
        database.save(record) { record, error in
            if record != nil, error == nil {
                print("saved task")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    print("adding to vm")
                    self.taskCellViewModels.insert(taskVM, at: 0)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.fetchTasks()
                  
                }
            }
        }
    
    }
}
