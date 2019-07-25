//
//  UpdateRestaurantViewController.swift
//  AdminApp
//
//  Created by Nesma Tharwat on 7/5/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit
import SVProgressHUD
import CoreLocation
import SDWebImage
class UpdateOrAddRestaurantViewController: UIViewController , CLLocationManagerDelegate {
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var restaurantImageView: UIImageView!
    
    @IBOutlet weak var restaurantNameTxtField: UITextField!
    
    @IBOutlet weak var restaurantCityTxtField: UITextField!
    
    @IBOutlet weak var restaurantCountryTextField: UITextField!
    @IBOutlet weak var latitudeTxtField: UITextField!
    
    @IBOutlet weak var longitudeTxtField: UITextField!
    
    @IBOutlet weak var addOrUpdateRestuarantBtn: RoundedButton!
    
    
    @IBOutlet weak var addOrUpdatePhoto: RoundedButton!
    
     var isValidName, isValidCity, isValidCountry,isImageUploaded : Bool?
    @IBOutlet weak var nameErrorLabel: UILabel!
    @IBOutlet weak var cityErrorLabel: UILabel!
    @IBOutlet weak var countryErrorLabel: UILabel!
    @IBOutlet weak var longitudeErrorLabel: UILabel!
    @IBOutlet weak var latitudeErrorLabel: UILabel!
    
    
    let locationManager = CLLocationManager()
    var lat:Double?
    var longt:Double?
    var check:Bool = true
    var flag :Int?
    var restaurantData = Restaurant()
    var restaurantDao = RestuarantDao()
    var restaurantsDelegate : RestaurantListDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if flag == 1 {
            isValidName = false
            isValidCity = false
            isValidCountry = false
            isImageUploaded = false
        }
        
print("\(flag!)")
        if flag! == 2 {
            
        updateUIToUpdate()
            isValidName = true
            isValidCity = true
            isValidCountry = true
            isImageUploaded = true
            
        }
        
    
    }
    
    @IBAction func restaurantNameTxtFiledEditChanged(_ sender: UITextField) {
        if (sender.text?.isEmpty)! {
            isValidName = false
            nameErrorLabel.text = "The Name is required!"
        }
        else{
            isValidName = true
            nameErrorLabel.text = ""
        }
        
    }
    
    @IBAction func citytxtEditChanged(_ sender: UITextField) {
        
        if (sender.text?.isEmpty)! {
            isValidCity = false
            cityErrorLabel.text = "City is required!"
            
        }
        else{
            isValidCity = true
            cityErrorLabel.text = ""
            
        }
        enableaddOrUpdateButton()
   
        
    }
    
    @IBAction func countryEditChanged(_ sender: UITextField) {
        
        
        if (sender.text?.isEmpty)! {
            isValidCountry = false
            countryErrorLabel.text = "Country is required!"
            
            
        }
        else{
            isValidCountry = true
            countryErrorLabel.text = ""
            
            
        }
        enableaddOrUpdateButton()
        
    }
    
    

    @IBAction func editPhoto(_ sender: UIButton) {
        
        let myPickerController = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            
            myPickerController.delegate = self
            myPickerController.sourceType = .savedPhotosAlbum
            myPickerController.allowsEditing = false
            
            present(myPickerController, animated: true, completion: nil)
            
        }

    }
   
    @IBAction func updateRestaurantDataAction(_ sender: Any) {
        addOrUpdateRestuarantBtn.isEnabled = false
        SVProgressHUD.show()
        guard let resturantName = restaurantNameTxtField.text , !resturantName.isEmpty else {
            SVProgressHUD.dismiss()
            
            nameErrorLabel.text = "The Name is required!"
            return
        }
        
        guard let city = restaurantCityTxtField.text ,!city.isEmpty else {
            SVProgressHUD.dismiss()
            cityErrorLabel.text = "The City is required!"
            return
        }
        guard let country = restaurantCountryTextField.text ,!country.isEmpty else {
            SVProgressHUD.dismiss()
            restaurantCountryTextField.text = "Country is required!"
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
        
        
        if flag! == 2 {
         updateRestaurant()
        }
        else if flag! == 1 {
        
        addNewResaurant(resturantName: resturantName,city: city,country: country,longitude: longitude,latitude: latitude)
        }
        
        
    }
    func enableaddOrUpdateButton(){
        if isValidName! && isValidCity! && isValidCountry! && isImageUploaded!{
            addOrUpdateRestuarantBtn.isEnabled = true;
            
        }
        else {
            addOrUpdateRestuarantBtn.isEnabled = false;
        }
    }
    
    //MARK-: add function for insert data
    func addNewResaurant(resturantName:String,city:String, country:String, longitude:String,latitude:String ){
        
        restaurantDao.addRestuarant(name: resturantName, city: city, country: country, longitude: longitude, latitude: latitude, restaurantImage: restaurantData.image!, completionHandler: {(id)
            in
            SVProgressHUD.dismiss()
            
            if id==0 {
                
                
                print("no data saved")
                SVProgressHUD.showError(withStatus: "Unfortianatly No Data Saved")
            }
            else{
                SVProgressHUD.showSuccess(withStatus:"Restaurant Saved Successfully")
                self.moveToAdminVC(id:id)
                
                
            }
            
        })
        
    
    }
    func moveToAdminVC(id :Int){
    
        
        let restaurantAdminVC = self.storyboard?.instantiateViewController(withIdentifier: "restaurantAdminVC") as! AddRestuarantAdminViewController
        restaurantAdminVC.restaurantId = id
        restaurantAdminVC.imgUrl = restaurantData.image!
        if flag! == 2 {
            restaurantAdminVC.flag = 2
        restaurantAdminVC.adminData = restaurantData.admin!
        }
        if flag! == 1 {
        restaurantAdminVC.flag = 1
        }
        self.navigationController?.pushViewController(restaurantAdminVC, animated: true)
        
        
    }
    func returnBackToRestaurantList(){
    self.navigationController?.popToRootViewController(animated: true)
        
    }
    func updateUIToUpdate(){
        
        restaurantNameTxtField.text = restaurantData.restaurantName!
        restaurantCityTxtField.text = restaurantData.city!
       longitudeTxtField.text = "\(restaurantData.longitude!)"
        latitudeTxtField.text = "\(restaurantData.latitude!)"
        restaurantCountryTextField.text = restaurantData.country!
        
        restaurantImageView.sd_setShowActivityIndicatorView(true)
               restaurantImageView.sd_setIndicatorStyle(.gray)
                restaurantImageView.sd_setImage(with: URL(string: ImageAPI.getImage(type: .original, publicId: restaurantData.image!)), completed: nil)
        isImageUploaded = true

        addOrUpdateRestuarantBtn.setTitle("Update", for: .normal)
        addOrUpdatePhoto.setTitle("update photo",for: .normal)
        
    
    }
    func updateRestaurant(){
        
        let parameters : [String:Any] = [
            "restaurantId" : restaurantData.restaurantID!,
            "restaurantName" :  (restaurantNameTxtField.text)! ,
            "city" : restaurantCityTxtField.text!,
            "country" : restaurantCountryTextField.text!,
            "longitude" :  Double((longitudeTxtField.text)!)! ,
            "latitude" :  Double((latitudeTxtField.text)!)! ,
            "restaurantImage" : (restaurantData.image)!
            
            
        ]
        
        restaurantDao.updateRestaurant(parameters: parameters, restaurantId: restaurantData.restaurantID!,completionHandler:{(code) in
        SVProgressHUD.dismiss()
        if (code == -1) || (code == 0)
        {
            SVProgressHUD.showError(withStatus: "Unfortianatly No Data Saved")
            
            }
        else {
            SVProgressHUD.showSuccess(withStatus: "restuarant updated succesfully", maskType: .gradient)
            let alert = UIAlertController(title: "Do You Want To Update The Admin Data Too?", message: "Click Yes If you Want To Update the Admin Data.", preferredStyle: .actionSheet
            )
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
            
            self.moveToAdminVC(id: self.restaurantData.restaurantID!)
            
            
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
            self.returnBackToRestaurantList()
            
            
            
            }))
            
            self.present(alert, animated: true)
            
            }
            
            
        })
        
    
    }
    

}
//MARK: - Select image from gallery
extension UpdateOrAddRestaurantViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let imageData: Data = UIImageJPEGRepresentation(image, 0.2)!
            
            uploadImage(imageData)
            
            restaurantImageView.image = image
            isImageUploaded = true
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - Image Uploading
extension UpdateOrAddRestaurantViewController {
    
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
       
        restaurantImageView.alpha = 0.3
    }
    
    
    func uploadCompleted() {
        imageActivityIndicator.stopAnimating()
        SVProgressHUD.dismiss()
        restaurantImageView.alpha = 1.0
        
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

extension UpdateOrAddRestaurantViewController : MapViewSelectionDelegate {
    
    func setCoordinates(latInDelegate:Double , longtInDelegate:Double, isChecked:Bool) {
        
        self.check = isChecked
        self.latitudeTxtField.text = ""
        self.longitudeTxtField.text = ""
        
        self.latitudeTxtField.text = String(describing: latInDelegate) 
        self.longitudeTxtField.text = String(describing: longtInDelegate)
        
        
    }
    
}



