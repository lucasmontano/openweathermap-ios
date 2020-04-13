import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherDataResponse)
}

final class WeatherManager {
    private let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=c6e381d8c7ff98f0fee43775817cf6ad&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        getRequest(with: urlString)
    }
    
    private func getRequest(with utlString: String) {
        guard let url = URL(string: utlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, erro) in
            if erro != nil{
                return
            }
            if let safeData = data {
                if let weather = self.parseJSON(safeData){
                    self.delegate?.didUpdateWeather(weather: weather)
                }
            }
        }
        task.resume()
    }
    
    private func parseJSON(_ weatherData: Data) -> WeatherDataResponse? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            let cityName = decodeData.name
            let temp = decodeData.main.temp
            let description = decodeData.weather[0].description
            let id = decodeData.weather[0].id
            let weather = WeatherDataResponse(city: cityName, temp: temp, description: description, conditionId: id)
            return weather
        } catch {
            return nil
        }
    }
}
