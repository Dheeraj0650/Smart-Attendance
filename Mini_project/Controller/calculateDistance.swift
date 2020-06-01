//
//  calculateDistance.swift
//  Mini_project
//
//  Created by KOTTE V S S DHEERAJ on 01/06/20.
//  Copyright © 2020 KOTTE V S S DHEERAJ. All rights reserved.
//

import Foundation
import CoreLocation
class CalculateDistance{
    
    func getDistance(_ coordinate0:CLLocation,_ coordinate1:CLLocation) ->Double {
        return coordinate0.distance(from: coordinate1)
    }
}
