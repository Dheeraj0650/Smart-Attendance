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
    var get_distance = CalculateDistance()
    var coordinate0:CLLocation?
    
    func getLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
    }
    func distance(_ lat1:Double , _ lon1:Double, _ lat2:Double,_ lon2:Double) -> Double{
        let R = 6378.137
        let dLat = (lat2 * 3.14159265 / 180 ) - (lat1 * 3.14159265 / 180)
        let dLon = (lon2 * 3.14159265 / 180) - (lon1 * 3.14159265 / 180)
        let a = sin(dLat/2) * sin(dLat/2) +
        cos(lat1 * 3.14159265 / 180) * cos(lat2 * 3.14159265 / 180) *
        sin(dLon/2) * sin(dLon/2)
        let c = 2 * atan2(Double(0.5).squareRoot(), Double(1-a).squareRoot())
        let d = R * c
        return d * 1000;
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            self.location = "\(Double(round(1000*lat)/1000)) \(Double(round(1000*long)/1000))"
            delegate?.add_coordinates(self.location!)
            distance(lat, long, 18.42204398, 79.11506301)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
     print("error")
    }
    
}
