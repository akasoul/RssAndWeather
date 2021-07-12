//
//  AddNewRssView.swift
//  RssAndWeather
//
//  Created by Anton Voloshuk on 12.07.2021.
//

import SwiftUI

struct AddNewRssView: View {
    @ObservedObject var model = AddNewRssViewModel()
    var body: some View {
        GeometryReader{ g in
            VStack{
                TextField("Имя", text: self.$model.name)
                TextField("Ccылка", text: self.$model.url)
                Button("Добавить", action: {
                    self.model.addNew()
                })
            }
        }
        .padding(30)
    }
}

struct AddNewRssView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewRssView()
    }
}
