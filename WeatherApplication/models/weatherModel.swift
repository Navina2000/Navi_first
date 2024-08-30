//
//  apiCall.swift
//  WeatherApplication
//
//  Created by Della on 25/03/22.
//

import Foundation

struct WeatherModel
{
    let cName: String
    let temperature: Double
    let idName: Int
    let mainName: String
    let descripetionName: String
    let iconName: String
    let dateTime : Int
    let time : Int
    
    
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
}
