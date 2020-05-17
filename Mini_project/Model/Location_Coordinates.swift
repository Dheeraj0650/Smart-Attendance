//
//  Location_Coordinates.swift
//  Mini_project
//
//  Created by KOTTE V S S DHEERAJ on 16/05/20.
//  Copyright © 2020 KOTTE V S S DHEERAJ. All rights reserved.
//

import Foundation
import CoreLocation


class Location_coordinates:NSObject,CLLocationManagerDelegate{
    var locationManager = CLLocationManager()
    var delegate:add_LocationCoordinates?
    var location:String?
    func getLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            var lat = location.coordinate.latitude
            var long = location.coordinate.longitude
            self.location = "\(Double(round(1000*lat)/1000)) \(Double(round(1000*lat)/1000))"
            delegate?.add_coordinates(self.location!)
            print(self.location)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
     print("error")
    }
    
}
