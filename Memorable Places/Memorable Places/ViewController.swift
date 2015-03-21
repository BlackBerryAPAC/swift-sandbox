//
//  ViewController.swift
//  Memorable Places
//
//  Created by David Leonard on 3/21/15.
//  Copyright (c) 2015 David Leonard. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    var manager: CLLocationManager!
    
    @IBOutlet weak var map: MKMapView!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CLLocationManager();
        manager.delegate = self;
        manager.desiredAccuracy = kCLLocationAccuracyBest;
        manager.requestWhenInUseAuthorization();
        manager.startUpdatingLocation();
        
        // Configure long press of 2 seconds
        var uilpgr = UILongPressGestureRecognizer(target: self, action: "action:");
        uilpgr.minimumPressDuration = 2.0;
        map.addGestureRecognizer(uilpgr);
    }
    
    // Create gesture action function
    func action(gestureRecognizer: UIGestureRecognizer) {
        // Just check for the first indication of a particular long press
        // Makes sure the action is only performed once
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            var touchPoint = gestureRecognizer.locationInView(self.map);
            var newCoordinate = self.map.convertPoint(touchPoint, toCoordinateFromView: self.map);
            // Add annotation
            var annotation = MKPointAnnotation();
            annotation.coordinate = newCoordinate;
            annotation.title = "New Annotation";
            self.map.addAnnotation(annotation);
        }
    }

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var userLocation: CLLocation = locations[0] as CLLocation;
        var latitude = userLocation.coordinate.latitude;
        var longitude = userLocation.coordinate.longitude;
        var coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        var latDelta: CLLocationDegrees = 0.01;
        var lonDelta: CLLocationDegrees = 0.01;
        var span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta);
        var region: MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span);
        self.map.setRegion(region, animated: true);
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

