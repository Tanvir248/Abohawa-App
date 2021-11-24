//
//  weatherData.swift
//  Clima
//
//  Created by Tanvir Rahman on 20.11.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
struct weatherDatas: Codable {
    let name : String
    let main : Main
    let weather : [Weather]
    let sys : SYS
}
struct Main : Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Double
}
struct Weather: Codable {
   let description: String
    let id: Int
}
struct SYS: Codable {
    let sunrise: Int
    let sunset: Int
}
