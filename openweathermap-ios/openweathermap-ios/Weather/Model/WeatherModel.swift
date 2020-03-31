import Foundation

struct WeatherModel {
    let city: String
    let temp: Double
    let description: String
    
    var temperature: String {
        return String(format: "%.1f", temp)
    }
}
