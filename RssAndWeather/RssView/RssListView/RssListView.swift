//
//  RssListView.swift
//  RssAndWeather
//
//  Created by Anton Voloshuk on 12.07.2021.
//

import SwiftUI

struct RssListView: View {
    @ObservedObject var model = RssListViewModel()
    @State var showPopover = false
    var addNewRssView=AddNewRssView()
    var body: some View {
        GeometryReader{ g in
            NavigationView{
                List{
                    ForEach(self.model.sources,id:\.self){ i in
                        NavigationLink(destination: RssDetailView(url: i.url), label: {
                            VStack{
                                Text(i.name)
                                    .font(Font.system(size: 14))
                                    .frame(width: g.size.width,alignment:.topLeading)
                                Text(i.url)
                                    .font(Font.system(size: 13))
                                    .frame(width: g.size.width,alignment:.topLeading)
                            }
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
        }.popover(isPresented: self.$showPopover, content: {
            self.addNewRssView
                .onAppear(perform:{
                    self.addNewRssView.model.receiver=self.model
                })
        })
        .onReceive(self.model.$sources, perform: { i in
            self.showPopover=false
        })
    }
}

struct RssListView_Previews: PreviewProvider {
    static var previews: some View {
        RssListView()
    }
}
