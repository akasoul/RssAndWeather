//
//  Structs.swift
//  RssAndWeather
//
//  Created by Anton Voloshuk on 12.07.2021.
//

import Foundation



//MARK: - CurrentWeatherJSON
struct CurrentWeatherJSON: Codable,Equatable,Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    var coord: Coord?
    var weather: [Weather]?
    var base: String?
    var main: Main?
    var visibility: Int?
    var wind: Wind?
    var clouds: Clouds?
    var dt: Int?
    var sys: Sys?
    var timezone, id: Int?
    var name: String?
    var cod: Int?
    
    static let nilValue=CurrentWeatherJSON(coord: nil, weather: nil, base: nil, main: nil, visibility: nil, wind: nil, clouds: nil, dt: nil, sys: nil, timezone: nil, id: nil, name: nil, cod: nil)
}

struct Clouds: Codable,Equatable {
    var all: Int?
}

struct Coord: Codable,Equatable {
    var lon, lat: Double?
}

struct Main: Codable,Equatable {
    var temp, feelsLike, tempMin, tempMax: Double?
    var pressure, humidity: Int?
}

struct Sys: Codable,Equatable {
    var type, id: Int?
    var country: String?
    var sunrise, sunset: Int?
}

struct Weather: Codable,Equatable {
    var id: Int?
    var main, weatherDescription, icon: String?
}

struct Wind: Codable,Equatable {
    var speed: Double?
    var deg: Int?
}



//MARK: - Location
struct Location: Codable,Equatable{
    struct coordinates: Codable,Equatable{
        let lon: Double
        let lat: Double
    }
    let id: Int
    let name: String
    let country: String
    let state: String
    let coord: coordinates
}




// MARK: - DailyForecastJSON
struct DailyForecastJSON: Codable,Equatable  {
    var lat, lon: Double?
    var timezone: String?
    var timezoneOffset: Int?
    var daily: [Daily]?
}

struct Daily: Codable,Equatable,Hashable  {
    var dt, sunrise, sunset: Int?
    var temp: Temp?
    var feelsLike: FeelsLike?
    var pressure, humidity: Int?
    var dewPoint, windSpeed: Double?
    var windDeg: Int?
    var weather: [Weather]?
    var clouds: Int?
    var pop, uvi, rain, snow: Double?
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.dt)
    }
}

struct FeelsLike: Codable,Equatable  {
    var day, night, eve, morn: Double?
}

struct Temp: Codable,Equatable  {
    var day, min, max, night: Double?
    var eve, morn: Double?
}

struct DailyForecastForStorage: Codable,Equatable{
    var data:DailyForecastJSON?
    var dt: Date?
}
