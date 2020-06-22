//
//  MapViewController.swift
//  Mini_project
//
//  Created by KOTTE V S S DHEERAJ on 22/06/20.
//  Copyright © 2020 KOTTE V S S DHEERAJ. All rights reserved.
//


import UIKit
import MapKit


class MapViewController: UIViewController {
    

    @IBOutlet weak var mapView: MKMapView!
    let regionInMeters: CLLocationDistance = 10000
    var latitude:Double?
    var longitude:Double?
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        centerViewOnUserLocation()
    }
  

  
    func centerViewOnUserLocation() {
        if let latitude = latitude,let longitude = longitude  {
            
            let region = MKCoordinateRegion.init(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
 
    
}
