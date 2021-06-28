//
//  WeatherModel.swift
//  Clima
//
//  Created by Husain Mustafa on 16/06/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel
{
    let conditionId : Int // Stored Property
    let cityName : String // Stored Property
    let temperature : Double // Stored Property
    
    var temperatureString : String
    {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName : String // Computed Property
    {
        switch conditionId
        {
            case 200...232 :
                return "cloud.bolt"
            case 300...321 :
                return "cloud.drizzle"
            case 500...531 :
                return "cloud.heavyrain"
            case 600...622 :
                return "cloud.snow"
            case 701...781 :
                return "cloud.fog"
            case 800 :
                return "sun.max"
            case 801...804 :
                return "cloud"
                
            default:
                return "sun.max"
        }
    }
}
