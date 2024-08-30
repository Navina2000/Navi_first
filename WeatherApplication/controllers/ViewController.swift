//
//  ViewController.swift
//  WeatherApplication
//
//  Created by Della on 24/03/22.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate{
    var weatherManager  = WeatherManager()
    
    @IBOutlet weak var searchCityWeather: UITextField!
    @IBOutlet weak var cityname: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var cityTemp: UILabel!
    @IBOutlet weak var cityId: UILabel!
    @IBOutlet weak var cityMain: UILabel!
    @IBOutlet weak var cityDes: UILabel!
    @IBOutlet weak var cityIcon: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        searchCityWeather.resignFirstResponder()
    }
    
    @IBAction func searchButton(_ sender: Any) {
        searchCityWeather.endEditing(true)
        
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let cityName = searchCityWeather.text
        {
            weatherManager.fetchWeather(cityName: cityName)
        }
        print("textFieldDidEndEditing")
    }
    
    
}



func textFieldShouldClear(_ textField: UITextField) -> Bool {
    
    return true
}


extension ViewController:WeatherManagerDelegate{
    
    
    func didUpdateWeather(weatherManager: WeatherManager, weather: WeatherModel) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm:ss a"//yyyy
        //formatter.timeZone = TimeZone(abbreviation: "IST")
        let stringDate = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.dateTime+weather.time)))
        
        print(weather.cName)
        print(weather.temperatureString)
        DispatchQueue.main.async {
            self.cityname.text = "\(weather.cName)"
            self.cityTemp.text = ("\(weather.temperature)"+"°C")
            self.cityId.text = "\(weather.idName)"
            self.dateTime.text = stringDate
            self.cityMain.text = "\(weather.mainName)"
            self.cityDes.text = "\(weather.descripetionName)"
            self.cityIcon.text = "\(weather.iconName)"
            if weather.mainName == "Mist"{
                self.imageView.image = UIImage(named: "mist")
            }
                else if weather.mainName == "Rain"{
                    self.imageView.image = UIImage(named: "rain")
                }
            else if weather.mainName == "Clouds"{
                self.imageView.image = UIImage(named: "cloud")
            }
            else if weather.mainName == "Haze"{
                self.imageView.image = UIImage(named: "haze")
            }
            else if weather.mainName == "Fog"{
                self.imageView.image = UIImage(named: "fog")
            }
            else if weather.mainName == "Clear"{
                self.imageView.image = UIImage(named: "clear")
            }
                
            }
        }
    
    
    func didFailWithError(error: Error) {
        
        print(error)
    }
}




