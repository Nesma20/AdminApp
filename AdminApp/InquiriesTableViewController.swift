//
//  ReviewsTableViewController.swift
//  AdminApp
//
//  Created by Nesma Tharwat on 7/5/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage
class InquiriesTableViewController : UITableViewController {
var inquiryDao = InquiryDao()
    var inquiryList = Array<Inquiry>()
    override func viewDidLoad() {
        super.viewDidLoad()
    updateInquiryList()
        
        
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inquiryList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "inquiryCell", for: indexPath) as! UserInquiryTableViewCell
        

        // Configure the cell...
        
        let user = inquiryList[indexPath.row].user

        cell.userNameLabel.text = user.userName!
        cell.userEmailLabel.text = user.email!
        cell.userImageView.layer.cornerRadius = cell.userImageView.frame.width / 2
        cell.userImageView.layer.masksToBounds = true
        
        if let image = user.profileImage, !image.isEmpty {
            cell.userImageView.sd_setShowActivityIndicatorView(true)
            cell.userImageView.sd_setIndicatorStyle(.gray)
            cell.userImageView.sd_setImage(with: URL(string: ImageAPI.getImage(type: .profile_r250, publicId: image)), completed: nil)
        }

        return cell
    }
    func updateInquiryList(){
    
        
        inquiryDao.getAllInquiries(completionHandler: {(jsonList) in
            
            
        
        if jsonList.count == 0 {
            SVProgressHUD.showInfo(withStatus: "There are no inquiries to be displayed")
            
            
        }
            self.inquiryList = jsonList
            self.tableView.reloadData()
            
             })
        
        

    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var inquiryDetaildVC = self.storyboard?.instantiateViewController(withIdentifier: "inquiryDetailsVC") as! InquiryDetailsViewController
        inquiryDetaildVC.inquiry = inquiryList[indexPath.row]
        inquiryDetaildVC.inquiry.user = inquiryList[indexPath.row].user
        self.navigationController?.pushViewController(inquiryDetaildVC, animated: true)
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
