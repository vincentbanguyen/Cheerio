import Foundation
import CloudKit

struct Task {
    var recordId : CKRecord.ID?
    var title: String
    var completed: String
}
