//
//  ViewController.swift
//  Clima
//
//  Created by Tanvir on 12.11.2021.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    
    @IBOutlet weak var humiditylabel: UILabel!
    
    @IBOutlet weak var lowAndMaxTempLabel: UILabel!
    @IBOutlet weak var weatherCondiotionLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManger = weatherManager()
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

        weatherManger.delegate = self
        searchTextField.delegate = self
    }

   
    @IBAction func locationButton(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
}
extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchButton(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        }else {
            textField.placeholder = "Type a city name"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text {
            weatherManger.fetchWeather(cityName: city)
        }
       // temperatureLabel.text = weatherManger.getTemp(temper: 12.5)
        searchTextField.text = ""
    }
    
    
}

extension WeatherViewController: weatherManagerDelegate {
    func didUpadteWeather(_ weeatherManager: weatherManager , Weather: weatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = Weather.temperatureString
            self.cityLabel.text = Weather.cityName
            self.conditionImageView.image = UIImage(systemName: Weather.conditionName)
            //print(Weather.conditionName)
            //print(Weather.conditionId)
            self.weatherCondiotionLabel.text = "Conditions : \(Weather.description)"
            self.feelsLikeLabel.text = "Feels Like: \(Weather.feelsLike)°c"
            self.lowAndMaxTempLabel.text = "Low: \(Weather.miniTmp)°c, Max: \(Weather.maxiTmp)°c"
            self.humiditylabel.text = "Humidity: \(Weather.humidity)"
                //print(Weather.feelsLike)
            //self.sunriseLabel.text = "Sunrise: \(Weather.formattedTimeSunrise)"
            //print(Weather.formattedTimeSunrise)
           // self.sunsetLabel.text = "Sunset: \(Weather.formattedTimeSunset)"
            //print(Weather.formattedTimeSunset)
        }
        
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       // print("Get Locations")
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
           // print(lat)
          //  print(lon)
            weatherManger.fetchWeather(latitude: lat, longitude: lon)
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
