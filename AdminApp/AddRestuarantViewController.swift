//
//  AddRestuarantViewController.swift
//  AdminApp
//
//  Created by Nesma Tharwat on 6/22/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit
import SVProgressHUD
class AddRestuarantViewController: UIViewController {

    @IBOutlet weak var resturantImage: UIImageView!
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
        
        // add function for insert data 
        
        
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
            
            uploadUserImage(imageData)
            
            resturantImage.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - Image Uploading
extension AddRestuarantViewController {
    
    func uploadUserImage(_ imageData: Data) {
        
        uploadStarts()
        
        ImageAPI.uploadImage(imgData: imageData, completionHandler: { result in
            
            self.uploadCompleted()
            
            if let _ = result.0, let publicId = result.1 {
                self.restaurantData.image = publicId
            }
        })
    }
    
    
    func uploadStarts() {
      //  imageActivityIndicator.startAnimating()
        SVProgressHUD.showInfo(withStatus: "Image Was Uploading")
        
       resturantImage.alpha = 0.3
    }
    
    
    func uploadCompleted() {
       // imageActivityIndicator.stopAnimating()
        SVProgressHUD.dismiss()
        resturantImage.alpha = 1.0
        
    }
    
    
    
}

