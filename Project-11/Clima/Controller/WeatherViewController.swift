//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController
{
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager() // Provides current GPS Location
    
    @IBAction func displayDeviceLocationWeather(_ sender: UIButton)
    {
        
    }
    
    @IBAction func locationPressed(_ sender: UIButton)
    {
        locationManager.requestLocation()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        weatherManager.delegate = self
        searchTextField.delegate = self // This means the textfield should report back to the ViewController
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    
}

//MARK: - UITextFieldDelegate

extension  WeatherViewController: UITextFieldDelegate
{
    @IBAction func searchPressed(_ sender: UIButton)
    {
        searchTextField.endEditing(true)
        print(searchTextField.text ?? "Empty" )
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        searchTextField.endEditing(true)
        print(searchTextField.text ?? "Empty" )
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        // Use searchTextField.text to get the weather for that city
        if let city = searchTextField.text // Optional Unwrapping
        {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        if( searchTextField.text != "")
        {
            return true
        }
        else
        {
            searchTextField.placeholder = "Type something"
            return false
        }
    }
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate
{
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    {
        DispatchQueue.main.async
        {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailwithError(error: Error) {
        print(error)
    }
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if let location = locations.last
        {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print(error)
    }
}
