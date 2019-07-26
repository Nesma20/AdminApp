//
//  RestaruantsListViewController.swift
//  AdminApp
//
//  Created by Nesma Tharwat on 7/10/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit
import SVProgressHUD
class RestaruantsListViewController: UITableViewController, RestaurantListDelegate {

    var restaurantsData : Array<Restaurant> = []
    var restaurantDao = RestuarantDao()
    var restaurantSelected = Restaurant()
    var page :Int = 1
    var isAllDataDisplayed :Bool = false;
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewWillAppear(_ animated: Bool) {
        getRestaurantData(pageNum: page)
    }

   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurantsData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as! RestaurantTableViewCell

        cell.restaurantNameLbl.text = restaurantsData[indexPath.row].restaurantName
        if let image = restaurantsData[indexPath.row].image, !image.isEmpty {
            cell.restaurantImageView.sd_setShowActivityIndicatorView(true)
            cell.restaurantImageView.sd_setIndicatorStyle(.gray)
            cell.restaurantImageView.sd_setImage(with: URL(string: ImageAPI.getImage(type: .width150, publicId: image)), completed: nil)
        }
        if restaurantsData.count-1 == indexPath.row && !isAllDataDisplayed{
        
            page = page + 1
            getRestaurantData(pageNum: page)
            
        
        
        }
       

        return cell
    }
   

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
           
            restaurantDao.deleteRestaurant(restaurantId: restaurantsData[indexPath.row].restaurantID!, completionHandler:{code in
                if code == 1{
                SVProgressHUD.showSuccess(withStatus: "Restaurant is Deleted Successfully", maskType: .gradient)
                    self.restaurantsData.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    self.getRestaurantData(pageNum: self.page)
                    
                }
                else
                {
                SVProgressHUD.showError(withStatus: "Error While Deleting Restaurant")
                }
            
            })
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    func getRestaurantData(pageNum:Int){
        var restList:Array<Restaurant> = []
        restaurantDao.getRestaurantsList(pageNumber: pageNum, completionHandler: {(jsonList) in
            
            
            
            if pageNum==1
            
            {
                if jsonList.count == 0 {
                    SVProgressHUD.showInfo(withStatus: "There are no inquiries to be displayed")
                    self.isAllDataDisplayed = true
                    
                }
                else{
                self.restaurantsData = jsonList
                
                }
                
            
            }
            else if pageNum > 1
            {
                if jsonList.count != 0 {
                    restList = jsonList
                    self.restaurantsData.append(contentsOf: restList)
                    self.isAllDataDisplayed = false
                }
                else{
                self.isAllDataDisplayed = true
                }
            }
                
            self.tableView.reloadData()

          
          
        })
        
    }

   
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
     
        if segue.identifier == "showRestaurantDetails" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
             restaurantSelected = restaurantsData[indexPath.row]
          let restaurantDetailsVC : RestaurantDetailsViewController = segue.destination as! RestaurantDetailsViewController
            restaurantDetailsVC.restaurantDetails = restaurantSelected
            }
           
            
        }
        
        if segue.identifier == "AddNewRestaurant" {
            
            print ("segue for add button")
            let newRestaurantVC : UpdateOrAddRestaurantViewController = segue.destination as!
            UpdateOrAddRestaurantViewController
            newRestaurantVC.flag = 1
        }
       
    }
   
    func updateRestaurantList(){
        if !isAllDataDisplayed{
     getRestaurantData(pageNum: page)
        }
    
    }
    

}
