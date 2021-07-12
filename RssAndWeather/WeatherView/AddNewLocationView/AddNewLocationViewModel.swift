//
//  AddNewLocationViewModel.swift
//  RssAndWeather
//
//  Created by Anton Voloshuk on 12.07.2021.
//

import Foundation
import MapKit

protocol NewLocationReceiver: class{
    func addNewLocation(item: MKMapItem)
}

class AddNewLocationViewModel: ObservableObject{
    @Published var name: String=""{
        didSet{
            self.searchLocation(text: self.name)
        }
    }
    
    @Published var matchingItems=[MKMapItem]()
    @Published var selectedLocation: MKMapItem?{
        didSet{
            if let location = self.selectedLocation{
                self.receiver?.addNewLocation(item: location)
            }
        }
    }
    weak var receiver: NewLocationReceiver?
    init() {
        
    }
    
    func searchLocation(text: String){
        let request  = MKLocalSearch.Request()
        request.naturalLanguageQuery=text
        let search=MKLocalSearch(request: request)
        search.start(completionHandler: { response,error in
            guard let items = response?.mapItems
            else{ return }
            self.matchingItems=[]
            for i in items{
                self.matchingItems.append(i)
            }
        })
    }
    
}
