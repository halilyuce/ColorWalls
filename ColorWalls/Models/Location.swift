//
//  Location.swift
//  ColorWalls
//
//  Created by Halil İbrahim YÜCE on 28.01.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Location: Identifiable {
    var id: String
    var title: String
    var description: String
    var location: GeoPoint
    var logo: String
    var images: [String]
}
