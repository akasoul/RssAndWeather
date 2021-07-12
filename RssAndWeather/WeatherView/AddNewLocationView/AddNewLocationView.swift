//
//  AddNewLocationView.swift
//  RssAndWeather
//
//  Created by Anton Voloshuk on 12.07.2021.
//

import SwiftUI

struct AddNewLocationView: View {
    @ObservedObject var model  = AddNewLocationViewModel()
    var body: some View {
        GeometryReader{ g in
            VStack{
                TextField("Введите местоположение", text: self.$model.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                ScrollView{
                    VStack{
                        ForEach(self.model.matchingItems,id:\.self){ i in
                            Text(i.name ?? "")
                                .frame(width:g.size.width,height:g.size.height,alignment:.topLeading)
                                .onTapGesture(perform: {
                                    self.model.selectedLocation = i
                                    self.model.name=i.name ?? ""
                                })
                        }
                    }
                }
            }.frame(width: g.size.width,height:g.size.height,alignment:.topLeading)
        }.padding(20)
    }
}

struct AddNewLocationView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewLocationView()
    }
}
