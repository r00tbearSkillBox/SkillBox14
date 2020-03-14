import UIKit

class ViewController: UIViewController {
    
    var hours: [HourData] = []
    var days: [DailyData] = []
    var mainData: [String] = []
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var citiTemp: UILabel!
    
    @IBOutlet weak var appTableView: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        loadWeather()
        

    }
    
    func loadWeather() {
        
        
        let urlString = "https://api.darksky.net/forecast/f44d65453eb8779a6f59e379e8b02a2a/55.7522,37.6155?lang=ru&exclude=minutely,alerts,flags&units=auto"
        guard let url = URL(string: urlString) else { return }
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                guard error == nil else { return }
                
                do {
                    let cityWeather = try! JSONDecoder().decode(CityWeather.self, from: data)
                    
                    for i in 1...5 {
                        self.days.append(cityWeather.daily!.data![i])
                        print(self.days[i-1])
                        self.mainData.append("\(self.getDate(date: self.days[i-1].time!))" + "      " + "\(Int(self.days[i-1].temperatureHigh!))" + "˚C")
                    }
                    for i in 1...3 {
                        self.hours.append(cityWeather.hourly!.data![i])
                        print(self.hours[i-1])
                        self.mainData.append("\(self.getHour(hour: self.hours[i-1].time!))" + "      " + "\(Int(self.hours[i-1].temperature!))" + "˚C")
                    }

                    print("часы: ", self.hours.count)
                    print("дни: ", self.days.count)
                    print(self.mainData)
            
                    
                    DispatchQueue.main.async {
                        self.cityLabel.text = cityWeather.timezone!
                        self.citiTemp.text = "\(Int(cityWeather.currently!.temperature!))˚C"
                        self.appTableView.reloadData()
                    }
                    
                    
                } catch let error {
                    print(error.localizedDescription)
                }
                
                
            
            }.resume()

        }
    
    func getDate(date: Double) -> String {
        let dateString = NSDate(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "dd/MM" //"MMMM-dd-yyyy HH:mm"
         let date = dateFormatter.string(from: dateString as Date)
        return date
    }
    
    func getHour(hour: Double) -> String {
        let hourString = NSDate(timeIntervalSince1970: hour)
        let hourFormatter = DateFormatter()
         hourFormatter.dateFormat = "HH:mm"
         let hour = hourFormatter.string(from: hourString as Date)
        return hour
    }
    

    }

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mainData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dateCell = tableView.dequeueReusableCell(withIdentifier: "DateCell") as! DateCell
        dateCell.dateCellLabel.text = self.mainData[indexPath.row]

        return dateCell
        
    }
    
    
}

