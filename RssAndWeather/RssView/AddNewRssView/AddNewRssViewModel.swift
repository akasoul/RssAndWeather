//
//  AddNewRssViewModel.swift
//  RssAndWeather
//
//  Created by Anton Voloshuk on 12.07.2021.
//

import Foundation

protocol NewRssReceiver:class{
    func receive(name: String,url: String)
}
class AddNewRssViewModel: ObservableObject{
    @Published var name: String=""
    @Published var url: String=""
    weak var receiver: NewRssReceiver?
    init() {
        
    }
    func addNew(){
        self.receiver?.receive(name: self.name, url: self.url)
    }
}
