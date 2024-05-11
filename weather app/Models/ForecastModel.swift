//
//  ForecastModel.swift
//  weather app
//
//  Created by Jonatas Falkaniere on 06/05/24.
//

import Foundation

class ForecastModel {
    
    private let baseURL: String = "https://api.openweathermap.org/data/3.0/onecall"
    private let API_KEY: String = "927545a4dfdbe9c9bd3885a4a3f10c64"
    private let session = URLSession.shared
        
    internal var forecastResponse: ForecastResponse?

    func fetchData(city: City) -> Void {
        let urlString = "\(baseURL)?lat=\(city.lat)&lon=\(city.long)&cnt=16&appid=\(API_KEY)&units=metric"
        guard let url = URL(string: urlString) else { return }
        
        
        // tratar o response e o error
        let task = session.dataTask(with: url) { data, response, error in
            
            guard let data else {
                print("No data")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(ForecastResponse.self, from: data)
                self.forecastResponse = response
                
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
}

// MARK: - City request
struct City {
    let lat: String
    let long: String
    let name: String
}

// MARK: Forecast Default request data
struct DefaultCityData {
    static let city = City(lat: "-19.919048", long: "-43.938636", name: "Belo Horizonte")
}


// MARK: - ForecastResponse
struct ForecastResponse: Codable {
    let current: Forecast
    let hourly: [Forecast]
    let daily: [DailyForecast]
}

// MARK: - Forecast
struct Forecast: Codable {
    let dt: Int
    let temp: Double
    let humidity: Int
    let windSpeed: Double
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case dt, temp, humidity
        case windSpeed = "wind_speed"
        case weather
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

// MARK: - DailyForecast
struct DailyForecast: Codable {
    let dt: Int
    let temp: Temp
    let weather: [Weather]
}

// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}

