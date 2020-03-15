import Foundation

class Persistance {
    static let shared = Persistance()
    
    private let wCitiName = "Persistance.wCitiName"
    private let wCitiTemp = "Persistance.wCitiTemp"
    private let wMainData = "Persistance.wMainData"
//    mainData: [String] = []
    
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
