

import Foundation



protocol WeatherManagerDelegate {
    func didUpdateWeather(weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager
{
   let  weatherURL = "https://api.openweathermap.org/data/2.5/weather?&units=metric&appid=e6955b1f58cf532644cfc72fd16e90bc"
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
        // Step 1: Create a URL
    func performRequest(with urlString: String) {
        if let url  = URL(string: urlString) {
            
        //Step2: Create a URL Session
            let session  = URLSession(configuration: .default)
            
            
            //step 3: URL session request with a specified task
            
            
            //Data
            let task  = session.dataTask(with: url) { data, response, error in
                
                
                if error != nil
                {
                    print(error!)
                    return
                }
                
                if let safeData = data
                {
                   if let weather = self.parseJson(data: safeData)
                    {
                       self.delegate?.didUpdateWeather(weatherManager: self, weather: weather)
                       
                       print(weather)
                   }
                }
            }
            
            
            //Step4: start the task
            task.resume()
    
        }
    }
    
    func parseJson(data: Data) -> WeatherModel?
    {
        let jsonDecoder  = JSONDecoder()

        do
        {
           let decodedData =  try jsonDecoder.decode(WeatherData.self, from: data)
            
            let cityName = decodedData.name
            let cityTemp = decodedData.main.temp
            let cityid   = decodedData.weather[0].id
            let citymain = decodedData.weather[0].main
            let citydes  = decodedData.weather[0].description
            let cityicon = decodedData.weather[0].icon
            let citydate = decodedData.dt
            let citytime = decodedData.timezone
            
            let weather = WeatherModel(cName: cityName, temperature: cityTemp, idName: cityid, mainName: citymain, descripetionName: citydes, iconName: cityicon,dateTime: citydate,time: citytime)
            
            return weather
        }
        catch
        {
            print(error)
            return nil
        }
    }
}


// Assignment
/*
1. Get the data and fill the data in WeatherViewController
2. Place a label and image in storyboard
3. Try Updating the label and image as per city entered in UITextField
*/
