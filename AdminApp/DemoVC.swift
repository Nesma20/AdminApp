//
//  DemoVC.swift
//  AdminApp
//
//  Created by Mohamed Korany Ali on 10/19/1440 AH.
//  Copyright © 1440 AH Jets39. All rights reserved.
//

import UIKit
import CoreLocation

class DemoVC: UIViewController ,  CLLocationManagerDelegate {

    
    
    @IBOutlet weak var longitudeText: UITextField!
    @IBOutlet weak var latitudeText: UITextField!
    let locationManager = CLLocationManager()
    var lat:Double?
    var longt:Double?
    var check:Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    @IBAction func chooseLocationFromMap(_ sender: Any) {
       let mapVc = storyboard?.instantiateViewController(withIdentifier: "mapVC") as! mapViewController
        mapVc.mapViewSelectionDelegate = self
        present(mapVc, animated: true, completion: nil)
        
        
    }
    
    
    // 1
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            
            
            if check {
                print("Current location: \(currentLocation)")
                let coordinate = manager.location?.coordinate
                self.lat = coordinate?.latitude
                self.longt = coordinate?.longitude
                self.latitudeText.text = String(describing: self.lat!)
                self.longitudeText.text = String(describing: self.longt!)
            }
      }
    }
    
    // 2
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
    

    @IBAction func getCurrentLocationButton(_ sender: Any) {
        
        // 1
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        // 1
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return
            
        // 2
        case .denied, .restricted:
            let alert = UIAlertController(title: "Location Services disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
            return
        case .authorizedAlways, .authorizedWhenInUse:
            
            break
            
        }
        
        // 4
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        

        
    }
    

}
extension DemoVC : MapViewSelectionDelegate {

    func setCoordinates(latInDelegate:Double , longtInDelegate:Double, isChecked:Bool) {
        
        self.check = isChecked
        self.latitudeText.text = ""
        self.longitudeText.text = ""
        
        self.latitudeText.text = String(describing: latInDelegate) ?? "No Location Selected"
        self.longitudeText.text = String(describing: longtInDelegate) ?? "No Location Selected"
        
        
    
    
    }

}
