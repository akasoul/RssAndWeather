//
//  RssListViewModel.swift
//  RssAndWeather
//
//  Created by Anton Voloshuk on 12.07.2021.
//

import Foundation

class RssListViewModel: ObservableObject,NewRssReceiver{
    
    
    struct RssSource: Hashable,Codable{
        var name: String=""
        var url: String=""
    }
    @Published var sources: [RssSource]=[
        RssSource(name: "IXBT", url: "http://www.ixbt.com/export/news.rss"),
        RssSource(name: "Fontanka", url: "https://www.fontanka.ru/fontanka.rss"),
        RssSource(name: "Lenta", url: "https://lenta.ru/rss/news")
    ]{
        didSet{
            
                    let encoder=JSONEncoder()
                    if let encoded = try? encoder.encode(self.sources){
                        UserDefaults.standard.setValue(encoded, forKey: "rss")
                    }
        }
    }
    
    init() {
        let decoder=JSONDecoder()
        let value=UserDefaults.standard.value(forKey: "rss")
        if(value != nil){
            if let decoded = try? decoder.decode([RssSource].self, from: value! as! Data){
                self.sources=decoded
            }
        }

    }
    
    func removeAt(index: Int){
        self.sources.remove(at: index)
    }
    func receive(name: String, url: String) {
        self.sources.append(.init(name: name, url: url))
    }
}
