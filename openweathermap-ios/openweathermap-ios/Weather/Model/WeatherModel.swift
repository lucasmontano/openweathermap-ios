
struct WeatherModel {
    let city: String
    let temp: Double
    let description: String
    let conditionId: Int

    var temperature: String {
        return String(format: "%.1f", temp)
    }

    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "could.bolt"
        case 300...301:
            return "clod.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
