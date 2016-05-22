//
//  ViewController.swift
//  turtle-ninjas
//
//  Created by Vitor Oliveira on 5/20/16.
//  Copyright © 2016 Vitor Oliveira. All rights reserved.
//

import UIKit
import MapKit
import CoreData
import SwiftyJSON
import CoreLocation

class Maps: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, NSFetchedResultsControllerDelegate {

    // outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var viewFooter: UIView!
    @IBOutlet weak var txtStoreName: UILabel!
    @IBOutlet weak var starsRating: UIImageView!
    @IBOutlet weak var lblRating: UILabel!
    //
    
    let global = Global()
    var manager : CLLocationManager!
    let stores = mStores().read_stores()
    
    var selectedStore : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startLocationManager()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.loadAnnotations(stores!)
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
        let rating = self.stores![sender!.view!.tag].rate_score
        self.selectedStore = Int(self.stores![sender!.view!.tag].id)
        dispatch_async(dispatch_get_main_queue(), {
            self.viewFooter.hidden = false
            self.txtStoreName.text = self.stores![sender!.view!.tag].name
            self.lblRating.text = String(rating)
            self.starsRating.image = UIImage(named: "stars-\(floor(rating).format(0)).png")
        })
    }
    
    @IBAction func btnSearchClick(sender: AnyObject) {
        if let search = self.txtSearch.text {
            
            if search == "" {
                return
            }
            
            let url = "\(self.global.base_url)/search?q=\(search)"
            self.global.request(url, params: nil, headers: nil, type: HTTPTYPE.GET) { (response) in
                dispatch_async(dispatch_get_main_queue(), {
                    self.mapView.removeAnnotations(self.mapView.annotations)
                })
                self.loadAnnotationsViaSearch(response)
            }
            
        }
    }
    
    @IBAction func tapFooterView(sender: AnyObject) {
        dispatch_async(dispatch_get_main_queue()) {
            self.performSegueWithIdentifier("transMapToStore", sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender:AnyObject?){
        if (segue.identifier=="transMapToStore"){
            if let vc = segue.destinationViewController as? Store {
                vc.store_id = self.selectedStore
            }
        }
    }
    
    //
    // mark : private functions
    //
    
    private func loadAnnotations(stores: [Stores]) {
        if stores.count > 0 {
            for i in 0...stores.count-1 {
                dispatch_async(dispatch_get_main_queue()) {
                    let anotation = CustomPointAnnotation()
                    let location  = CLLocationCoordinate2D(latitude: stores[i].latitude, longitude: stores[i].longitude)
                
                    anotation.tag = i
                    anotation.coordinate = location
                
                    self.mapView.addAnnotation(anotation)
                }
            }
        }
    }
    
    private func loadAnnotationsViaSearch(stores: (JSON)) {
        if stores.count > 0 {
            for i in 0...stores.count-1 {
                dispatch_async(dispatch_get_main_queue()) {
                    let anotation = CustomPointAnnotation()
                    let location  = CLLocationCoordinate2D(latitude: stores[i]["latitude"].doubleValue, longitude: stores[i]["longitude"].doubleValue)
                
                    anotation.tag = i
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
            manager = CLLocationManager()
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