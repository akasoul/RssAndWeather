//
//  WeatherViewModel.swift
//  RssAndWeather
//
//  Created by Anton Voloshuk on 12.07.2021.
//

import Foundation
import Combine
import MapKit


class WeatherViewModel: ObservableObject,NewLocationReceiver{
    var observedLocations:[Location]=[]{
        didSet{
            let encoder=JSONEncoder()
            if let encoded = try? encoder.encode(self.observedLocations){
                UserDefaults.standard.setValue(encoded, forKey: "observedLocations")
            }
            self.requestWeather()
        }
    }
    
    @Published var currentWeather: [CurrentWeatherJSON]=[]{
        didSet{
            if(self.currentWeather==[]){
                return
            }
            var foundNil=false
            for i in 0..<self.currentWeather.count{
                if(self.currentWeather[i] == CurrentWeatherJSON.nilValue){
                    foundNil=true
                }
            }
            if !foundNil{

            }
        }
    }
    
    
    init() {
        let decoder=JSONDecoder()
        let value=UserDefaults.standard.value(forKey: "observedLocations")
        if(value != nil){
            if let decoded = try? decoder.decode([Location].self, from: value! as! Data){
                self.observedLocations=decoded
                self.requestWeather()
            }
        }
    }
    
    func requestWeather(){
        DispatchQueue.global().async{
            
            for i in 0..<self.observedLocations.count{
                if(i<self.currentWeather.count){
                    if(self.observedLocations[i].coord.lat==self.currentWeather[i].coord?.lat &&
                        self.observedLocations[i].coord.lon==self.currentWeather[i].coord?.lon){
                        continue
                    }
                }
                var answer=""
                var responseJson: CurrentWeatherJSON?
                //            let url = URL(string:"https://api.openweathermap.org/data/2.5/weather?id=\(self.observedLocations[i].id)&appid=0601def1087b7d7381320d12039fea10")
                let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(self.observedLocations[i].coord.lat)&lon=\(self.observedLocations[i].coord.lon)&appid=0601def1087b7d7381320d12039fea10")
                if(url == nil){
                    continue
                }
                let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
                    guard let data = data else { return }
                    answer=(String(data: data, encoding: .utf8)!)
                    do{
                        responseJson = try JSONDecoder().decode(CurrentWeatherJSON.self, from: answer.data(using: .utf8)!)
                        DispatchQueue.main.async{
                            self.currentWeather.append(responseJson ?? CurrentWeatherJSON.nilValue)
                        }
                    }
                    catch{
                        print(error)
                    }
                }
                
                task.resume()
                while !task.progress.isFinished{
                    sleep(1)
                }
            }
        }
    }
    
    func removeAt(index: Int){
        self.observedLocations.remove(at: index)
self.currentWeather.remove(at: index)
    }
    
    func addNewLocation(item: MKMapItem) {
        self.observedLocations.append(Location(id: 0, name: item.name ?? "", country: "", state: "", coord: Location.coordinates(lon: item.placemark.coordinate.longitude, lat: item.placemark.coordinate.latitude)))
    }
    
}
