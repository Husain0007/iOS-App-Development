//
//  WeatherManager.swift
//  Clima
//
//  Created by Husain Mustafa on 15/06/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate
{
    func didUpdateWeather(_ weatherManager : WeatherManager, weather: WeatherModel)
    func didFailwithError(error : Error)
}

struct WeatherManager
{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=dbb7918bcd2f61d0ac2b864d45957fa7&units=metric"
    
    var delegate : WeatherManagerDelegate?
    
    func fetchWeather(cityName: String)
    {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String)
    {
        // 1. Create a URL Object.
        if let url = URL(string: urlString)
        {
            // 2. Create a URL Session.
            let session = URLSession(configuration: .default)
            
            // 3. Give the URL Session a task.
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil
                {
                    self.delegate?.didFailwithError(error: error!) //inside closure
                    return
                }
                
                if let safeData = data
                {
                    if let weather = self.parseJSON(safeData) // "self" cause inside closure
                    {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            // 4. Start the task.
            task.resume()
            
        }
                
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?
    {
        let decoder = JSONDecoder()
        do
        {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            //print(decodedData.main.temp)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
            return weather
        }
        catch
        {
            delegate?.didFailwithError(error: error)
            return nil
        }
    }
    


    
}
