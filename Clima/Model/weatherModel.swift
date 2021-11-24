//
//  weatherModel.swift
//  Clima
//
//  Created by Tanvir Rahman on 20.11.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
struct weatherModel {
    let conditionId: Int
    let cityName : String
    let temperature : Double
    let description : String
    let feelsLike : Double
    let miniTmp : Double
    let maxiTmp : Double
    let humidity: Int
    let sunrise : Int
    let sunst : Int
    var temperatureString: String{
            return String(format: "%.1f", temperature)
    }
        //sunrising time formated from api 
    var formattedTimeSunrise: String {
        let sunriseDate = Date(timeIntervalSince1970:  TimeInterval(sunrise))
                   let formatter = DateFormatter()
                   formatter.dateStyle = .none
                   formatter.timeStyle = .medium

                   let formattedTime = formatter.string(from: sunriseDate)
        return formattedTime;
    }
    //sunset time calculator from api
    var formattedTimeSunset: String {
        let sunriseDate = Date(timeIntervalSince1970:  TimeInterval(sunst))
                   let formatter = DateFormatter()
                   formatter.dateStyle = .none
                   formatter.timeStyle = .medium

                   let formattedTime = formatter.string(from: sunriseDate)
        return formattedTime;
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
             return "cloud.bolt.fill"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...711:
            return "smoke.fill"
        case 712...771:
            return "sun.dust.fill"
        case 781:
            return "tornado"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.sun"
        default:
            return "cloud"
        }
    }
    
}
