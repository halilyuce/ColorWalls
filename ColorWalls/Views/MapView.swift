//
//  MapView.swift
//  ColorWalls
//
//  Created by Halil İbrahim YÜCE on 18.01.2020.
//  Copyright © 2020 Halil İbrahim YÜCE. All rights reserved.
//

import SwiftUI
import GoogleMaps
import Firebase
import Combine

struct MapView: UIViewRepresentable {
    
    @ObservedObject var locationManager = LocationManager()
    @ObservedObject var fbData = firebaseData
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    func makeUIView(context: Self.Context) -> GMSMapView {
        
        let camera = GMSCameraPosition.camera(withLatitude: 0, longitude: 0, zoom: 16.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.delegate = context.coordinator
        do {
            if colorScheme == .dark {
                let styleURL = Bundle.main.url(forResource: "dark", withExtension: "json")
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL!)
            }else {
                let styleURL = Bundle.main.url(forResource: "light", withExtension: "json")
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL!)
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        mapView.settings.compassButton = true
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
        mapView.settings.rotateGestures = true
        mapView.settings.tiltGestures = true
        mapView.isIndoorEnabled = false
        
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Self.Context) {
        
        DispatchQueue.main.async {
            if let myLocation = self.locationManager.lastKnownLocation {
                mapView.animate(toLocation: myLocation.coordinate)
            }
            for mark in self.fbData.data {
                let marker : GMSMarker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: mark.location.latitude, longitude: mark.location.longitude)
                marker.title = mark.title
                marker.userData = mark
                marker.snippet = mark.description
                marker.map = mapView
            }
        }
    }
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

final class Coordinator: NSObject, GMSMapViewDelegate {
    var control: MapView
    
    init(_ control: MapView) {
        self.control = control
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let window = UIApplication.shared.windows.first
        var vc = DetailView()
        vc.marker = marker
        vc.location = marker.userData as! Location
        window?.rootViewController?.present(UIHostingController(rootView: vc), animated: true)
        return true
    }
}

