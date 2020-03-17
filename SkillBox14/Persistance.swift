import Foundation
import RealmSwift

class Persistance {
    static let shared = Persistance()
    
    private let wCitiName = "Persistance.wCitiName"
    private let wCitiTemp = "Persistance.wCitiTemp"
    private let wMainData = "Persistance.wMainData"
    
    var citiName: String? {
        set { UserDefaults.standard.set(newValue, forKey: wCitiName) }
        get { return UserDefaults.standard.string(forKey: wCitiName) }
    }
    
    var citiTemp: String? {
        set { UserDefaults.standard.set(newValue, forKey: wCitiTemp) }
        get { return UserDefaults.standard.string(forKey: wCitiTemp) }
    }
    
    var mainData: Array<String>? {
        set { UserDefaults.standard.set(newValue, forKey: wMainData) }
        get { return (UserDefaults.standard.array(forKey: wMainData) as? Array<String>) }
    }
    
}

class PersistanceNames {
    static let shared = PersistanceNames()
    
    private let nName = "PersistanceNames.nName"
    private let nLastName = "PersistanceNames.nLastName"
    
    var name: String? {
        set { UserDefaults.standard.set(newValue, forKey: nName) }
        get { UserDefaults.standard.string(forKey: nName) }
    }
    
    var lastName: String? {
        set { UserDefaults.standard.set(newValue, forKey: nLastName) }
        get { UserDefaults.standard.string(forKey: nLastName) }
    }
}

class TasksRealm: Object {
    @objc dynamic var task = ""
}

class PersistanceRealm {
    static let shared = PersistanceRealm()
    private let realm = try! Realm()
    
    func saveTask(task: String) {
        let tasks = TasksRealm()
        tasks.task = task
        try! realm.write {
            realm.add(tasks)
        }
        
    }
    
    func loadTask() -> [String] {
        let allTasks = realm.objects(TasksRealm.self)
        var tasks: [String] = []
        for task in allTasks {
            tasks.append("\(task.task)")
        }
        return tasks
    }
    
    func deleteTask(withId: Int) {
        let taskToDelete = realm.objects(TasksRealm.self)[withId]
        try! realm.write {
            realm.delete(taskToDelete)
        }
    }
}
