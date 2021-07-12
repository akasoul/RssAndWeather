//
//  LocationWeatherView.swift
//  RssAndWeather
//
//  Created by Anton Voloshuk on 12.07.2021.
//

import Foundation
import SwiftUI

struct CurrentWeatherView: View {
    @ObservedObject var model = CurrentWeatherViewModel()
    @State var showForecast: Bool = false
    var locationName: String
    var temperature: Double
    var imgName:String
    var body: some View{
        GeometryReader{ g in
            ZStack{
                Color.clear.contentShape(Rectangle())
                HStack{
                    Text(self.locationName)
                }
                .frame(width:g.size.width,height:g.size.height,alignment:.leading)
                HStack{
                    Text(String(format:"%.0f ºC",self.temperature))
                    Image(self.imgName)
                }
                .frame(width:g.size.width,height:g.size.height,alignment:.trailing)
            }.frame(height:g.size.height)
            .padding(5)
            .onAppear(perform: {
                print(self.temperature)
            })
        }
    }
}
