//
//  weatherManager.swift
//  Clima
//
//  Created by Tanvir Rahman on 20.11.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation
protocol weatherManagerDelegate{
    func didUpadteWeather(_ weeatherManager: weatherManager , Weather: weatherModel)
    func didFailWithError(error: Error)
}
struct weatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=17bf4a42cdbf129cc7d64846875cfef5&units=metric"
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        //print(urlString)
        performRequest(urlSring: urlString)
    }
    var delegate: weatherManagerDelegate?
   func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
       let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
       performRequest(urlSring: urlString)
    }
    
    func performRequest(urlSring : String){
        //create url
        if let url = URL(string: urlSring) {
            //create URLsession
            let session = URLSession(configuration: .default)
            //give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    //parseJSON(weatherData: safeData)
                    if let weather = parseJSON(weatherData: safeData) {
                        self.delegate?.didUpadteWeather(self, Weather: weather)
                    }
                }
            }
            //stop task
            task.resume()
        }
        func parseJSON(weatherData: Data) -> weatherModel? {
            let decoder = JSONDecoder()
            do{
                let decodedData = try decoder.decode(weatherDatas.self, from: weatherData)
                let temp = decodedData.main.temp
                let id = decodedData.weather[0].id
                let name = decodedData.name
                let descript = decodedData.weather[0].description
                let feelLike = decodedData.main.feels_like
                let minTemp = decodedData.main.temp_min
                let maxTemp = decodedData.main.temp_max
                let humidity = decodedData.main.humidity
                let sunrise = decodedData.sys.sunrise
                let sunset = decodedData.sys.sunset
                print(sunset)
                //print(descript)
                let weather = weatherModel(conditionId: id, cityName: name, temperature: temp, description: descript, feelsLike: feelLike, miniTmp: minTemp, maxiTmp: maxTemp, humidity: Int(humidity),sunrise: sunrise, sunst: sunset)
               //print(weather.)
              ///print(getTemp(temper: temp))
                return weather
            }catch{
                delegate?.didFailWithError(error: error)
                return nil
            }
        }
    }
//    func getTemp(temper: Double)->String{
//        return String(temper);
//    }
}
