//
//  mapViewController.swift
//  AdminApp
//
//  Created by Mohamed Korany Ali on 10/19/1440 AH.
//  Copyright © 1440 AH Jets39. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class mapViewController:UIViewController{
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var myMapView: MKMapView!
    let annotation = MKPointAnnotation()

    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        
        
        let latitude: CLLocationDegrees = 30.596335
        let longitude: CLLocationDegrees = 32.271353
        
        let regionDistance:CLLocationDistance = 100
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        myMapView.setRegion(regionSpan, animated:true)
    
        
        
        myMapView.isZoomEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        myMapView.addGestureRecognizer(gestureRecognizer)        }
        
    func handleTap(_ gestureReconizer: UILongPressGestureRecognizer) {
        
        let location = gestureReconizer.location(in: myMapView)
        let coordinate = myMapView.convert(location,toCoordinateFrom: myMapView)
        
        // Add annotation:
        
        annotation.coordinate = coordinate
        myMapView.addAnnotation(annotation)
        print(coordinate.latitude ?? 125)
    }
    
    func openMapForPlace() {
        
        let latitude: CLLocationDegrees = 30.596335
        let longitude: CLLocationDegrees = 32.271353
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Place Name"
        mapItem.openInMaps(launchOptions: options)
    }
}

