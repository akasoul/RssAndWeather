//
//  WeatherView.swift
//  RssAndWeather
//
//  Created by Anton Voloshuk on 12.07.2021.
//

import Foundation
import SwiftUI

struct ObservedLocationsView:View {
    @ObservedObject var model = ObservedLocationsViewModel()
    @State var showPopover=false
    let dstView = AddNewLocationView()
    
    var body: some View{
        GeometryReader{ g in
            NavigationView{
                List{
                    ForEach(self.model.currentWeather,id:\.self){ i in
                        NavigationLink(destination: DetailView(coordinates: i.coord), label: {
                            CurrentWeatherView(locationName: i.name ?? "", temperature: ((i.main?.temp ?? 273.15)-273.15),imgName: String(i.weather?[0].icon ?? ""))
                                .frame(height:50)
                        })
                    }
                    .onDelete(perform:{i in
                        guard let index = i.map({ $0}).first
                        else{ return }
                        self.model.removeAt(index: index)
                    })
                }.toolbar(content: {
                    ToolbarItemGroup(placement: ToolbarItemPlacement.navigationBarTrailing){
                        Button(action: { self.showPopover=true }, label: { Image(systemName: "plus.app")})
                    }
                })
            }
        }
        .popover(isPresented: self.$showPopover, content: {
            self.dstView
                .onAppear(perform:{
                    self.dstView.model.receiver=self.model
                })
        })
        .onReceive(self.model.$currentWeather,perform: { i in
            self.showPopover=false
        })
    }
}
