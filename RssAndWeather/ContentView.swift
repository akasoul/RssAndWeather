//
//  ContentView.swift
//  RssAndWeather
//
//  Created by Anton Voloshuk on 12.07.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            WeatherView().tabItem({
                Image(systemName: "cloud")
            })
            RssListView().tabItem({
                Image(systemName: "newspaper")
            })
        }
    }
}

