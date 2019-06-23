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
    var mapViewSelectionDelegate: MapViewSelectionDelegate!
    var lat:Double?
    
    var longt:Double?
    
    @IBAction func SelectLocationIsDone(_ sender: Any) {
        
        mapViewSelectionDelegate.setCoordinates(latInDelegate:lat!, longtInDelegate: longt!,isChecked: false)
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var myMapView: MKMapView!
    let annotation = MKPointAnnotation()

    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        
        
        let latitude: CLLocationDegrees = 30.596335
        let longitude: CLLocationDegrees = 32.271353
        
        let regionDistance:CLLocationDistance = 10000
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
        lat =  coordinate.latitude
        longt = coordinate.longitude
        
        print(coordinate.latitude ?? 125)
    }
    
   }

protocol MapViewSelectionDelegate {
    
    func setCoordinates(latInDelegate:Double , longtInDelegate:Double , isChecked:Bool)
    
}

