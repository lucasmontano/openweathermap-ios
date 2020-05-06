
struct WeatherDataResponse: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

extension WeatherDataResponse {
    struct Main: Codable {
        let temp: Double
    }
    
    struct Weather: Codable {
        let description: String
        let id: Int
    }
}
