import CoreLocation

protocol WeatherManagerDelegate: class {
    func didUpdateWeather(weather: WeatherModel)
}

final class WeatherManager {
    private let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=c6e381d8c7ff98f0fee43775817cf6ad&units=metric"
    
    weak var delegate: WeatherManagerDelegate?
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        getRequest(with: urlString)
    }
    
    private func getRequest(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data else { return }
            guard let self = self else { return }
            guard let weather = self.parseJSON(data) else { return }
            self.delegate?.didUpdateWeather(weather: weather)
        }
        task.resume()
    }
    
    private func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        guard let decodeData = try? decoder.decode(WeatherDataResponse.self, from: weatherData) else { return nil }
        let cityName = decodeData.name
        let temp = decodeData.main.temp
        guard let description = decodeData.weather.first?.description else { return nil }
        guard let id = decodeData.weather.first?.id else { return nil }
        return WeatherModel(city: cityName, temp: temp, description: description, conditionId: id)
    }
}
