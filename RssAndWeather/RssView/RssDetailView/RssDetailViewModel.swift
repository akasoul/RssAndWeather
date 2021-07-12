//
//  RssViewModel.swift
//  RssAndWeather
//
//  Created by Anton Voloshuk on 12.07.2021.
//

import Foundation


class RssDetailViewModel: NSObject, ObservableObject, XMLParserDelegate{
    
    struct XMLElements: Hashable{
        var elementName: String=""
        var source: String=""
        var author: String=""
        var title: String=""
        var date: String=""
        var link: String=""
        var description: String=""
    }
    var source: URL?{
        didSet{
            guard let url = self.source
            else{
                return
            }
            let dataTask = URLSession.shared.dataTask(with: url){ data,response,error in
                guard let data = data
                else{ return }
                let parser = XMLParser.init(data: data)
                parser.delegate=self
                parser.parse()
                
            }
            dataTask.resume()

        }
    }
    var parserElements = XMLElements()
    @Published var elements: [XMLElements]=[]
    override init() {
        super.init()

    }
    
    func parserDidStartDocument(_ parser: XMLParser) {
        
    }
    func parserDidEndDocument(_ parser: XMLParser) {
        print(parser)
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if(elementName == "item"){
            self.parserElements=XMLElements()
        }
        self.parserElements.elementName=elementName
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName == "item"){
            self.elements.append(self.parserElements)
        }
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (!data.isEmpty) {
            if self.parserElements.elementName == "title" {
                self.parserElements.title += data
            } else if self.parserElements.elementName == "author" {
                self.parserElements.author += data
            } else if self.parserElements.elementName == "link"{
                self.parserElements.link += data
            } else if self.parserElements.elementName == "description"{
                self.parserElements.description += data
            } else if self.parserElements.elementName == "date"{
                self.parserElements.date += data
            }
        }

    }
}



