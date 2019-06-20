//
//  VerificationViewController.swift
//  AdminApp
//
//  Created by Nesma Tharwat on 6/19/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit
import SVProgressHUD
private  let reuseIdentifier:String = "imgeIDCell"

class VerificationViewController: UIViewController {
    let verifyUser :Int = 1
    let blockUser :Int = 3
    var usersListDelegate :UsersListDelegate!
    
  var userDao=UserDao()
    @IBOutlet weak var imagesIDCollectionView: UICollectionView!
    var userData = User()
    @IBOutlet weak var nationalIDLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        imagesIDCollectionView.reloadData()
        nationalIDLabel.text = userData.nationalID
        imagesIDCollectionView.dataSource = self
        imagesIDCollectionView.delegate = self
        
        self.navigationItem.hidesBackButton = true
        let leftBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(back(sender:)))
        
        self.navigationItem.leftBarButtonItem = leftBackButton
    }
    
    func back(sender: UIBarButtonItem) {
        
        usersListDelegate.updateUsersList()
        
         self.navigationController?.popViewController(animated: true)
    }



    @IBAction func verifyUserBtn(_ sender: Any) {
      
        userDao.verifyOrBlockUser(userId: userData.userID!, verifyID: verifyUser, completionHandler:
            {(isverificationCompleted) in
               

                if isverificationCompleted{
                print("user Verified")
                    SVProgressHUD.showSuccess(withStatus: "User Verified Successfully")
                    
                
                }
                else
                {
                print("error while verify User")
                }
                
        
        })
    }

 
    @IBAction func blockUserBtn(_ sender: Any) {
        
        userDao.verifyOrBlockUser(userId: userData.userID!, verifyID: blockUser, completionHandler:
            {(isverificationCompleted) in
                SVProgressHUD.dismiss()
                
                if isverificationCompleted{
                    print("user Blocked Successfully")
                    
                }
                else
                {
                    print("error while block User")
                }
                
                
        })
    }


}

extension VerificationViewController :
UICollectionViewDataSource,UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
       return  1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! imgeIDCollectionViewCell
        
        if(indexPath.item == 0)
        {
        cell.imgIDLabel.text = "front image"
            
            if let image = userData.nationalID_Front, !image.isEmpty {
                cell.imageIDImageView.sd_setShowActivityIndicatorView(true)
                cell.imageIDImageView.sd_setIndicatorStyle(.gray)
                cell.imageIDImageView.sd_setImage(with: URL(string: ImageAPI.getImage(type: .width500, publicId: image)), completed: nil)
            }
        
        }
        else
        {
            
        cell.imgIDLabel.text = "back image"
            if let image = userData.nationalID_Back, !image.isEmpty {
                cell.imageIDImageView.sd_setShowActivityIndicatorView(true)
                cell.imageIDImageView.sd_setIndicatorStyle(.gray)
                cell.imageIDImageView.sd_setImage(with: URL(string: ImageAPI.getImage(type: .width500, publicId: image)), completed: nil)
            }
            
        }
        
        

        return cell
    }

}
