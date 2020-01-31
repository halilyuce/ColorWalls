//
//  ContentView.swift
//  ColorWalls
//
//  Created by Halil İbrahim YÜCE on 12.01.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import SwiftUI
import GoogleMaps

struct ContentView: View {
    
    var body: some View {
        TabView {
            MapView()
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("Harita")
                }.tag(0)
            Text("Keşfet")
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Keşfet")
                }.tag(1)
            Text("Ayarlar")
            .tabItem {
                Image(systemName: "3.circle")
                Text("Ayarlar")
            }.tag(1)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
