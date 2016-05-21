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
    
    var fakeDictionary : Dictionary<Int,[String:Double]> =
                         [1: ["latitude": 49.307136, "longitude": -123.024729],
                          2: ["latitude": 49.307024, "longitude": -123.027615,],
                          3: ["latitude": 49.305975, "longitude": -123.028323,]]
    
    var manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startLocationManager()
        self.loadClosestAnnotations(fakeDictionary)
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
 
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier("pin")
        
        if pinView == nil {
      
            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            pinView!.canShowCallout = true
            pinView!.calloutOffset = CGPoint(x: -5, y: 5)
            pinView!.image = UIImage(named:"turtle.jpg")
            pinView!.frame.size = CGSize(width: 45.0, height: 45.0)
            
        }
        
        return pinView
        
    }
    
    //
    // mark : private functions
    //
    
    private func loadClosestAnnotations(locations: Dictionary<Int,[String:Double]>) {
        
        for i in 1...locations.count {
            
            dispatch_async(dispatch_get_main_queue()) {
                if let annotation = locations[i] {
                
                    let anotation = MKPointAnnotation()
                    let location  = CLLocationCoordinate2D(latitude: annotation["latitude"]!, longitude: annotation["longitude"]!)
                    
                    anotation.title = "Title"
                    anotation.subtitle = "Subtitle"
                    anotation.coordinate = location
                    
                    self.mapView.addAnnotation(anotation)
                    
                }
            }
            
        }
        
    }
    
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