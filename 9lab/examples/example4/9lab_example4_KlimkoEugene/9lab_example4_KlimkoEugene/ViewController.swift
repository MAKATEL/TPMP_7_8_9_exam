//
//  ViewController.swift
//  9lab_example4_KlimkoEugene
//
//  Created by MacOSExi on 17.05.24.
//  Copyright © 2024 MacOSExi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapKit: MKMapView!
    var locManager = CLLocationManager();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locManager.delegate=self;
        locManager.distanceFilter=kCLLocationAccuracyNearestTenMeters;
        locManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        // setup mapView
           mapKit.delegate = self
           mapKit.showsUserLocation = true
        mapKit.userTrackingMode = .follow
        
           // setup test data
           setupData()
        
        locManager.startUpdatingLocation();
        
        
        // Do any additional setup after loading the view.
    }
    
    func setupData() {
        //check if system can monitor regions
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
     
            //region data
            let title = "BSU"
            let coordinate = CLLocationCoordinate2DMake(53.893026, 27.54)
            let regionRadius = 300.0
     
            //setup region
            let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: coordinate.latitude,
                longitude: coordinate.longitude), radius: regionRadius, identifier: title)
            locManager.startMonitoring(for: region)
     
            // setup annotation
            let restaurantAnnotation = MKPointAnnotation()
            restaurantAnnotation.coordinate = coordinate;
            restaurantAnnotation.title = "\(title)";
            mapKit.addAnnotation(restaurantAnnotation)
     
            let circle = MKCircle(center: coordinate, radius: regionRadius)
            mapKit.addOverlay(circle)
        }
        else {
            print("System can't track regions")
        }
    }
     
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let circleRenderer = MKCircleRenderer(overlay: overlay)
            circleRenderer.strokeColor = UIColor.red
            circleRenderer.lineWidth = 1.0
            return circleRenderer
        }
    
    


}

