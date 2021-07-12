//
//  RssItemDetailView.swift
//  RssAndWeather
//
//  Created by Anton Voloshuk on 12.07.2021.
//

import SwiftUI

struct RssItemDetailView: View {
    var title: String
    var date: String
    var description: String

    var body: some View {
        GeometryReader{ g in
            ScrollView{
            VStack(spacing:10){
                Text(self.date)
                    .frame(width:g.size.width,alignment:.topLeading)
                Text(self.title)
                    .frame(width:g.size.width,alignment:.topLeading)
                Text(self.description)
                    .frame(width:g.size.width,alignment:.topLeading)
            }
            }
        }
    }
}

