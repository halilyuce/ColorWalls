//
//  LocationListViewModel.swift
//  ColorWalls
//
//  Created by Halil İbrahim YÜCE on 12.01.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation

class LocationListViewModel: ObservableObject {
    @Published var location = [LocationViewModel]()
    
    init() {
        
        Webservice().getLocations { locations in
            
            if let locations = locations {
                self.location = locations.map(LocationViewModel.init)
            }
        }
        
    }
    
}

struct LocationViewModel {
    
    var location: currentLocation
    
    init(location: currentLocation) {
        self.location = location
    }
    
    var id: Int {
        return self.location.id
    }
    
    var title: String {
        return self.location.title
    }
    
    var body: String {
        return self.location.body
    }
    
}
