//
//  DetailViewModel.swift
//  RssAndWeather
//
//  Created by Anton Voloshuk on 12.07.2021.
//

import Foundation

class DetailViewModel: ObservableObject{
    var jsonData: DailyForecastJSON?
    @Published var dailyWeather: [Daily]=[]
    var coordinates: Coord?{
        didSet{
            guard let coordinates=self.coordinates
            else{
                return
            }
            guard let lat=coordinates.lat,
                  let lon=coordinates.lon
            else{
                return
            }
            guard let url=URL(string:"https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=hourly,current,minutely,alerts&appid=0601def1087b7d7381320d12039fea10")
            else{
                return
            }
            var answer: String=""
            var jsonData: DailyForecastJSON?
            let task=URLSession.shared.dataTask(with: url){data, response, error in
                guard let data = data else { return }
                answer=(String(data: data, encoding: .utf8)!)
                do{
                    jsonData = try JSONDecoder().decode(DailyForecastJSON.self, from: answer.data(using: .utf8)!)
                    
                }
                catch{
                    return
                }
                if(jsonData!.daily==nil){
                    return
                }
                
                var tmp: [Daily]=[]
                for i in 0..<jsonData!.daily!.count{
                    tmp.append(jsonData!.daily![i])
                }
                self.dailyWeather=tmp
                
            }
            task.resume()

        }
    }
    init() {
    }
}
