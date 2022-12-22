//
//  WeatherManager.swift
//  WeatherApp_SwiftUI
//
//  Created by Ziad Alfakharany on 20/9/2022.
//

import Foundation


class WeatherManager: ObservableObject {
    
    @Published var txtField: String = ""
    @Published var tmp: String = "22"
    @Published var cityLabel: String = "London"
    @Published var conditionImageView: String = "cloud.heavyrain.fill"
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=7ab6bf206c1f5c762b38b507e101420d&units=metric"
    
    
    func fetchWeather(cityName: String) {
        let URLString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: URLString)
    }
    
    
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            print(url)
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(conditionID: id, cityName: name, temperture: temp)
            return weather
            
        }catch {
            didFailWithError(error: error)
            return nil
        }
    }
    
    
    func  searchButtonPressed() {
        fetchWeather(cityName: txtField)
    }
    
    func didUpdateWeather(_ WeatherManager: WeatherManager  ,weather: WeatherModel) {
        DispatchQueue.main.async {
            self.tmp = weather.tempertureString
            self.conditionImageView = weather.conditionName
            self.cityLabel = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}



