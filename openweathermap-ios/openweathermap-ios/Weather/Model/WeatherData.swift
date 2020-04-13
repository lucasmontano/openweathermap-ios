
struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

extension WeatherData {
    struct Main: Codable {
        let temp: Double
    }
    
    struct Weather: Codable {
        let description: String
        let id: Int
    }
}
