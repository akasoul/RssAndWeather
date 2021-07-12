//
//  RssView.swift
//  RssAndWeather
//
//  Created by Anton Voloshuk on 12.07.2021.
//

import Foundation
import SwiftUI

struct RssDetailView:View {
    @ObservedObject var model = RssDetailViewModel()
    init(url: String) {
        self.model.source=URL(string: url)
    }
    var body: some View{
        GeometryReader{ g in
//            NavigationView{
                List{
                    ForEach(self.model.elements,id:\.self){ i in
                        NavigationLink(destination: RssItemDetailView(title: i.title, date: i.date, description: i.description), label: {
                            VStack{
                                Text(i.date)
                                Text(i.title)
//                                Text(i.name)
//                                    .font(Font.system(size: 14))
//                                    .frame(width: g.size.width,alignment:.topLeading)
                            }
                        })
                    }
                    
//                }
            }
        }
        .padding(10)
    }
}
