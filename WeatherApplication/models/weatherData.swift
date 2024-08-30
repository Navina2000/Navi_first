//
//  weatherData.swift
//  WeatherApplication
//
//  Created by Della on 28/03/22.
//

import Foundation
struct WeatherData: Decodable {
    let name : String
    let dt : Int
    let main : Main
    let wind : Wind
    let weather :[Weather]
    let timezone : Int
    
}

struct Main: Decodable
{
    let temp: Double
}

struct Weather: Decodable
{
    let id: Int
    let main: String
    let description: String
    let icon: String
}
struct Wind: Decodable
{
    
}
