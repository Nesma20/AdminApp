//
//  RestaurantDetailsViewController.swift
//  AdminApp
//
//  Created by Nesma Tharwat on 7/10/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit
import MapKit
import SDWebImage
class RestaurantDetailsViewController: UIViewController {

    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var RestaurantNameLabel: UILabel!
    @IBOutlet weak var RestaurantCityLabel: UILabel!
    @IBOutlet weak var restaurantCountryLabel: UILabel!
    
    @IBOutlet weak var restaurantLocationMapKitView: MKMapView!
    let locationManager = CLLocationManager()
    let annotation = MKPointAnnotation()
    var restaurantDetails = Restaurant()
   
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        restaurantCountryLabel.text = restaurantDetails.country!
        RestaurantCityLabel.text = restaurantDetails.city!
        RestaurantNameLabel.text = restaurantDetails.restaurantName!
        if let image = restaurantDetails.image, !image.isEmpty {
            restaurantImageView.sd_setShowActivityIndicatorView(true)
            restaurantImageView.sd_setIndicatorStyle(.gray)
            restaurantImageView.sd_setImage(with: URL(string: ImageAPI.getImage(type: .width150, publicId: image)), completed: nil)

        }
        
        let latitude: CLLocationDegrees = restaurantDetails.latitude!
        let longitude: CLLocationDegrees = restaurantDetails.longitude!
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let restaurantDataOnMap = RestaurantDataOnMap(title: restaurantDetails.restaurantName!,city: restaurantDetails.city!, coordinate: coordinates)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        restaurantLocationMapKitView.setRegion(regionSpan, animated:true)
        
        restaurantLocationMapKitView.addAnnotation(restaurantDataOnMap)
        
        restaurantLocationMapKitView.isZoomEnabled = true

        

        
    }

 
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "updateRestaurantData" {
          
            
                let updateRestaurantVC : UpdateOrAddRestaurantViewController = segue.destination as! UpdateOrAddRestaurantViewController
                updateRestaurantVC.restaurantData = restaurantDetails
            updateRestaurantVC.flag = 2
            }

        
    }
  

}
