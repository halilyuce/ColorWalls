//
//  Firebase.swift
//  ColorWalls
//
//  Created by Halil İbrahim YÜCE on 28.01.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import FirebaseFirestore

let dbCollection = Firestore.firestore().collection("places")
let firebaseData = FirebaseData()

class FirebaseData: ObservableObject {
    
    @Published var data = [Location]()
    
    init() {
        readData()
    }
    
    func readData() {
        dbCollection.addSnapshotListener { (documentSnapshot, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }else {
                print("read success")
            }
            
            documentSnapshot!.documentChanges.forEach { diff in
                    // Real time create from server
                    if (diff.type == .added) {
                        let msgData = Location(id: diff.document.documentID, title: diff.document.get("title") as! String, description: diff.document.get("description") as! String, location: diff.document.get("location") as! GeoPoint, logo: diff.document.get("logo") as! String, images: diff.document.get("images") as! [String])
                        self.data.append(msgData)
                    }
                    
                    // Real time modify from server
                    if (diff.type == .modified) {
                        self.data = self.data.map { (eachData) -> Location in
                            var data = eachData
                            if data.id == diff.document.documentID {
                                data.title = diff.document.get("title") as! String
                                data.description = diff.document.get("description") as! String
                                data.location = diff.document.get("location") as! GeoPoint
                                data.logo = diff.document.get("logo") as! String
                                data.images = diff.document.get("images") as! [String]
                                return data
                            }else {
                                return eachData
                            }
                        }
                    }
                }
        }
    }
}
