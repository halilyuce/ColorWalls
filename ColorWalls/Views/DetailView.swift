//
//  DetailView.swift
//  ColorWalls
//
//  Created by Halil İbrahim YÜCE on 18.01.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import Foundation
import SwiftUI
import GoogleMaps
import Firebase
import SDWebImageSwiftUI


struct DetailView: View {
    
    let window = UIApplication.shared.windows.first
    var marker = GMSMarker()
    var location = Location(id: "", title: "", description: "", location: GeoPoint(latitude: 0, longitude: 0), logo: "", images: [""])
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            VStack {
                WebImage(url: URL(string: location.logo))
                    .resizable()
                    .indicator(.activity)
                    .animation(.easeInOut(duration: 0.5))
                    .transition(.fade)
                    .scaledToFit()
                    .frame(width: 150, height: 150, alignment: .center)
                ScrollView{
                    HStack{
                        ForEach(location.images, id: \.self) { image in
                            WebImage(url: URL(string: image))
                                .resizable()
                                .indicator(.activity)
                                .animation(.easeInOut(duration: 0.5))
                                .transition(.fade)
                                .scaledToFill()
                                .frame(width: 72, height: 72, alignment: .center)
                        }
                    }
                }
                Text(location.description)
                    .padding()
                Button("Haritada Git") {
                    if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
                        
                        UIApplication.shared.open(NSURL(string:
                            "comgooglemaps://?saddr=&daddr=\(self.location.location.latitude),\(self.location.location.longitude)&directionsmode=driving")! as URL)
                        
                    }
                        
                    else if (UIApplication.shared.canOpenURL(NSURL(string:"http://maps.apple.com/maps")! as URL)) {
                        // apple map
                        let url = "http://maps.apple.com/maps?daddr=\(self.location.location.latitude),\(self.location.location.longitude)"
                        UIApplication.shared.open(URL(string:url)!)
                    }
                }
            }
            .navigationBarTitle(Text(location.title), displayMode: .inline)
            .navigationBarItems(leading: Button("Kapat") {
                self.window?.rootViewController?.dismiss(animated: true)
            }.foregroundColor(.red), trailing: Button("Paylaş") {
                let vc = UIActivityViewController(activityItems: [self.location.title], applicationActivities: [])
                if let topController = UIApplication.shared.windows.last {
                    topController.rootViewController?.present(vc, animated: true, completion: nil)
                }})
        }
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
