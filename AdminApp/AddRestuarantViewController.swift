//
//  AddRestuarantViewController.swift
//  AdminApp
//
//  Created by Nesma Tharwat on 6/22/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit
import SVProgressHUD
import CoreLocation
class AddRestuarantViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var lat:Double?
    var longt:Double?
    var check:Bool = true
    var isValidName, isValidCity, isValidCountry,isImageUploaded : Bool?
    
    @IBOutlet weak var addPhotoBtn: UIButton!
    var restaurantDao = RestuarantDao()
    @IBOutlet weak var resturantImage: UIImageView!
    
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var resturantNameTxtField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var countryTxtField: UITextField!
    @IBOutlet weak var longitudeTxtField: UITextField!
    @IBOutlet weak var latitudeTxtField: UITextField!
    @IBOutlet weak var addRestuarantBtn: UIButton!
    var restaurantData = Restaurant()
    @IBOutlet weak var nameErrorLabel: UILabel!
    @IBOutlet weak var cityErrorLabel: UILabel!
    @IBOutlet weak var countryErrorLabel: UILabel!
    @IBOutlet weak var longitudeErrorLabel: UILabel!
    @IBOutlet weak var latitudeErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        isImageUploaded = false
        isValidName = false
        isValidCity = false
        isValidCountry = false
        
        addPhotoBtn.layer.cornerRadius = addPhotoBtn.frame.height / 2
        addPhotoBtn.layer.masksToBounds = true
        addRestuarantBtn.layer.cornerRadius = addRestuarantBtn.frame.height / 2
        addRestuarantBtn.layer.masksToBounds = true
        
        
    }
    
    @IBAction func nameTxtChangedAction(_ sender: UITextField) {
        if (sender.text?.isEmpty)! {
        isValidName = false
            nameErrorLabel.text = "The Name is required!"
        }
        else{
         isValidName = true
        nameErrorLabel.text = ""
        }
        enableAddingButton()
    }
    
    @IBAction func cityTxtChangedAction(_ sender: UITextField) {
        if (sender.text?.isEmpty)! {
            isValidCity = false
            cityErrorLabel.text = "City is required!"
            
        }
        else{
            isValidCity = true
             cityErrorLabel.text = ""
            
        }
        enableAddingButton()

    }
    
    @IBAction func countryTxtChnaged(_ sender: UITextField) {
        
        if (sender.text?.isEmpty)! {
            isValidCountry = false
            countryErrorLabel.text = "Country is required!"
            
            
        }
        else{
            isValidCountry = true
            countryErrorLabel.text = ""

            
        }
        enableAddingButton()

    }
    
    func enableAddingButton(){
        if isValidName! && isValidCity! && isValidCountry! {
            addRestuarantBtn.isEnabled = true;
        
        }
        else {
            addRestuarantBtn.isEnabled = false;

        }
    }
    
    @IBAction func addRestuarantBtnAction(_ sender: Any) {
        addRestuarantBtn.isEnabled = false
        SVProgressHUD.show()
        guard let resturantName = resturantNameTxtField.text , !resturantName.isEmpty else {
            SVProgressHUD.dismiss()
            
            nameErrorLabel.text = "The Name is required!"
            return
        }
        
        guard let city = cityTextField.text ,!city.isEmpty else {
            SVProgressHUD.dismiss()
            cityErrorLabel.text = "The City is required!"
            return
        }
        guard let country = countryTxtField.text ,!country.isEmpty else {
            SVProgressHUD.dismiss()
            countryTxtField.text = "Country is required!"
            return
        }
        guard let longitude = longitudeTxtField.text ,!longitude.isEmpty else {
            SVProgressHUD.dismiss()
            longitudeErrorLabel.text = "longitude is required!"
            return
        }
        
        guard let latitude = latitudeTxtField.text ,!latitude.isEmpty else {
            SVProgressHUD.dismiss()
            latitudeErrorLabel.text = "Latitude is required!"
            return
        }
        
        //MARK-: add function for insert data
        
        addRestuarantBtn.isEnabled = false;
        SVProgressHUD.show()
        
        restaurantDao.addRestuarant(name: resturantName, city: city, country: country, longitude: longitude, latitude: latitude, restaurantImage: restaurantData.image!, completionHandler: {(id)
        in
            SVProgressHUD.dismiss()
            
            if id==0 {
                
            
            print("no data saved")
                SVProgressHUD.showError(withStatus: "Unfortianatly No Data Saved")
            }
            else{
            SVProgressHUD.showSuccess(withStatus:"Restaurant Saved Successfully")
                
           let restaurantAdminVC = self.storyboard?.instantiateViewController(withIdentifier: "restaurantAdminVC") as! AddRestuarantAdminViewController
            restaurantAdminVC.restaurantId = id
            restaurantAdminVC.imgUrl = self.restaurantData.image
                self.navigationController?.pushViewController(restaurantAdminVC, animated: true)
                
            
            }
            
        })
        
        
    }

    @IBAction func addPhotoBtnAction(_ sender: Any) {
        let myPickerController = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            
            myPickerController.delegate = self
            myPickerController.sourceType = .savedPhotosAlbum
            myPickerController.allowsEditing = false
            
            present(myPickerController, animated: true, completion: nil)
        }
        
    }

    }






//MARK: - Select image from gallery
extension AddRestuarantViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let imageData: Data = UIImageJPEGRepresentation(image, 0.2)!
            
            uploadImage(imageData)
            
            resturantImage.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - Image Uploading
extension AddRestuarantViewController {
    
    func uploadImage(_ imageData: Data) {
        
        uploadStarts()
        
        ImageAPI.uploadImage(imgData: imageData, completionHandler: { result in
            
            self.uploadCompleted()
            
            if let _ = result.0, let publicId = result.1 {
                self.restaurantData.image = publicId
            }
        })
    }
    
    
    func uploadStarts() {
      imageActivityIndicator.startAnimating()
        SVProgressHUD.showInfo(withStatus: "Image Was Uploading")
        
       resturantImage.alpha = 0.3
    }
    
    
    func uploadCompleted() {
       imageActivityIndicator.stopAnimating()
        SVProgressHUD.dismiss()
        resturantImage.alpha = 1.0
        
    }
    
    @IBAction func chooseLocationFromMap(_ sender: UIButton) {
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
                self.latitudeTxtField.text = String(describing: self.lat!)
                self.longitudeTxtField.text = String(describing: self.longt!)
            }
        }
    }
    
    // 2
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
    
    
    @IBAction func getCurrentLocationButton(_ sender: UIButton) {
        
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

extension AddRestuarantViewController : MapViewSelectionDelegate {
    
    func setCoordinates(latInDelegate:Double , longtInDelegate:Double, isChecked:Bool) {
        
        self.check = isChecked
        self.latitudeTxtField.text = ""
        self.longitudeTxtField.text = ""
        
        self.latitudeTxtField.text = String(describing: latInDelegate) ?? "No Location Selected"
        self.longitudeTxtField.text = String(describing: longtInDelegate) ?? "No Location Selected"
        
        
    }
    
}


