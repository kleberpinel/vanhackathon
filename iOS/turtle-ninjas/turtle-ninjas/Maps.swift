//
//  ViewController.swift
//  turtle-ninjas
//
//  Created by Vitor Oliveira on 5/20/16.
//  Copyright © 2016 Vitor Oliveira. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON
import CoreLocation

class Maps: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate  {

    // outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var viewFooter: UIView!
    @IBOutlet weak var txtStoreName: UILabel!
    //
    
    let global = Global()
    var manager = CLLocationManager()
    
    var store_json = JSON("")
    var selectedStore : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startLocationManager()
        
        let url = "\(self.global.base_url)"
        self.global.request(url, params: nil, headers: nil, type: HTTPTYPE.GET) { (response) in
            self.store_json = response
            self.loadAnnotations(response)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
     
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let region = MKCoordinateRegionMakeWithDistance(location, 1500.0, 1700.0)
        
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
            pinView!.image = UIImage(named:"shopify-logo")
            pinView!.frame.size = CGSize(width: 45.0, height: 45.0)
            
            let touchUserImage = UITapGestureRecognizer(target:self, action: #selector(Maps.showFooter(_:)))

            if (annotation is CustomPointAnnotation) {
                pinView?.tag = (annotation as! CustomPointAnnotation).tag
            }
            
            pinView!.addGestureRecognizer(touchUserImage)
            
            
        }
        
        return pinView
        
    }
    
    func showFooter(sender: UITapGestureRecognizer? = nil) {
        self.selectedStore = sender!.view!.tag
        dispatch_async(dispatch_get_main_queue(), {
            self.viewFooter.hidden = false
            print(sender!.view!.tag)
            self.txtStoreName.text = self.store_json[sender!.view!.tag]["name"].stringValue
        })
    }
    
    @IBAction func btnSearchClick(sender: AnyObject) {
    
        if let _ = self.txtSearch.text {
            
            if self.txtSearch.text == "" {
                return
            }
            
            let url = "\(self.global.base_url)"
            self.global.request(url, params: nil, headers: nil, type: HTTPTYPE.GET) { (response) in
                self.loadAnnotations(response)
            }
            
        }
        
    }
    
    //
    // mark : private functions
    //
    
    private func loadAnnotations(stores: (JSON)) {
        
        for i in 1...stores.count {
            
            dispatch_async(dispatch_get_main_queue()) {
                let anotation = CustomPointAnnotation()
                let location  = CLLocationCoordinate2D(latitude: stores[i]["latitude"].doubleValue, longitude: stores[i]["longitude"].doubleValue)
                
                anotation.tag = i
                anotation.title = stores[i]["name"].stringValue
                anotation.subtitle = stores[i]["street"].stringValue
                anotation.coordinate = location
                    
                self.mapView.addAnnotation(anotation)
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