import Foundation

struct CityWeather: Decodable {
    let timezone: String?
    let currently: CarrentWeather?
    let hourly: Hourly?
    let daily: Daily?
}

struct CarrentWeather: Decodable {
    let temperature: Double?
}

struct Hourly: Decodable {
    let data: [HourData]?
}

struct HourData: Decodable {
    let time: Double?
    let temperature: Double?
}

struct Daily: Decodable {
    let data: [DailyData]?
}

struct DailyData: Decodable {
    let time: Double?
    let temperatureHigh: Double?
}
