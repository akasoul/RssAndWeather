//
//  DetailView.swift
//  RssAndWeather
//
//  Created by Anton Voloshuk on 12.07.2021.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var model = DetailViewModel()
    let formatter=DateFormatter()
    

    init(coordinates: Coord?) {
        formatter.locale=Locale(identifier: "en_US")
        formatter.setLocalizedDateFormatFromTemplate("MMMd")

        guard let coordinates=coordinates
        else{
            return
        }
        self.model.coordinates = coordinates
    }
    var body: some View {
        GeometryReader{ g in
            ScrollView{
                VStack(spacing:20){
                    ForEach(self.model.dailyWeather,id:\.self){ i in
                        VStack{
                            Text(self.formatter.string(from: Date(timeIntervalSince1970: TimeInterval(i.dt ?? 0))))
                                .frame(width:g.size.width,alignment:.topLeading)
 Text(String(format:"%.1fºC",(i.temp?.min ?? 271.15)-271.15)+" ... "+String(format:"%.1fºC",(i.temp?.max ?? 271.15)-271.15))
                                .frame(width:g.size.width,alignment:.topLeading)
 }
                    }
                }
            }
        }.padding(20)
    }
}

