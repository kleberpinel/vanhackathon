//
//  ViewController.swift
//  turtle-ninjas
//
//  Created by Vitor Oliveira on 5/20/16.
//  Copyright © 2016 Vitor Oliveira. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Foundation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate  {

    @IBOutlet weak var mapView: MKMapView!
    
    var manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startLocationManager()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
     
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        
        let region = MKCoordinateRegionMakeWithDistance(location, 500.0, 700.0)
        
        self.mapView.setRegion(region, animated: true)
        
    }
 
    //
    // mark : private functions
    //
    
    private func startLocationManager(){
        
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        
        // Check whether or not GPS is turned on
        if (CLLocationManager.locationServicesEnabled()) {
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
            manager.distanceFilter = 100.0
        } else {
            // SplitMango's latitude and longitude
            // 223 Mountain Hwy, North Vancouver, BC V7J 3V3, Canada
            let getLat: CLLocationDegrees = ("49.305898" as NSString).doubleValue
            let getLon: CLLocationDegrees = ("-123.026843" as NSString).doubleValue
            
            let location = CLLocationCoordinate2D(latitude: getLat, longitude: getLon)
            let region = MKCoordinateRegionMakeWithDistance(location, 500.0, 700.0)
            
            self.mapView.setRegion(region, animated: true)
        }
        
    }
    
}