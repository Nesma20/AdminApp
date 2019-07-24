//
//  UserSummaryViewController.swift
//  AdminApp
//
//  Created by Ahmed M. Hassan on 7/7/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit
import SVProgressHUD
import Charts

class AdminSummaryViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var chartView: LineChartView!
    @IBOutlet weak var dailyCollectionView: UICollectionView!
    @IBOutlet weak var monthlyCollectionView: UICollectionView!
    @IBOutlet weak var floatingLabel: UILabel!
    @IBOutlet weak var floatingLabelCenterConstraint: NSLayoutConstraint!
    
    
    // Properties
    var summary: Summary?
    let typeArray = ["Used Coupons", "Created Coupons", "Registered Users", "Reserved Coupons", "Used Coupons", "Created Coupons"]
    let unitArray = ["EGP", "EGP", "User", "Coupon", "Coupon", "Coupon"]
    var dailyArray = [AnyHashable]()
    var monthlyArray = [AnyHashable]()
    let cellIdentifier = "SummaryCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup chart view & set delegate
        chartView.setupLineChartView()
        chartView.delegate = self
        floatingLabel.isHidden = true
        
        // Register xib view to collections
        dailyCollectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        monthlyCollectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        // Send request to get summary
        getSummary()
    }

    private func getSummary() {
        
        SVProgressHUD.show()
        
        AdminDao.getAdminSummary { result in
            
            SVProgressHUD.dismiss()
            
            guard let summary = result else {
                return
            }
            
            self.summary = summary
            
            self.updateData(summary: summary)
            
            self.setupLineChart(dictionary: summary.Users!, title: "New Users")
        }
    }
    
    private func updateData(summary: Summary) {
        
        dailyArray.removeAll()
        
        dailyArray.append(summary.daily?.usedCouponsValue ?? 0)
        dailyArray.append(summary.daily?.createdCouponsValue ?? 0)
        dailyArray.append(summary.daily?.registeredUsers ?? 0)
        dailyArray.append(summary.daily?.reservedCoupons ?? 0)
        dailyArray.append(summary.daily?.usedCoupons ?? 0)
        dailyArray.append(summary.daily?.createdCoupons ?? 0)
        
        dailyCollectionView.reloadData()
        
        monthlyArray.removeAll()
        
        monthlyArray.append(summary.monthly?.usedCouponsValue ?? 0)
        monthlyArray.append(summary.monthly?.createdCouponsValue ?? 0)
        monthlyArray.append(summary.monthly?.registeredUsers ?? 0)
        monthlyArray.append(summary.monthly?.reservedCoupons ?? 0)
        monthlyArray.append(summary.monthly?.usedCoupons ?? 0)
        monthlyArray.append(summary.monthly?.createdCoupons ?? 0)
        
        monthlyCollectionView.reloadData()
    }
    
    private func setupLineChart(dictionary: [String : Int], title: String) {
        var lineChartEntry = [ChartDataEntry]()
        
        var counter : Double = 0
        for (_, value) in dictionary.sorted(by: <) {
            counter += 1
            let entry = ChartDataEntry(x: counter, y: Double(value))
            lineChartEntry.append(entry)
        }
        
        let line1 = MyLineChartDataSet(values: lineChartEntry, label: title)
        
        let data = LineChartData(dataSets: [line1])
        data.setDrawValues(false)
        
        chartView.data = data
        
        chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInOutElastic)
    }
    
    
    @IBAction func didChangeSegmentControlValue(_ sender: UISegmentedControl) {
        
        guard let summary = self.summary else {
            return
        }
        
        switch sender.selectedSegmentIndex {
        case 0:
            setupLineChart(dictionary: summary.Users!, title: "New Users")
        case 1:
            setupLineChart(dictionary: summary.Coupons!, title: "New Coupons")
        case 2:
            setupLineChart(dictionary: summary.UserReserveCoupon!, title: "Reserved Coupons")
        case 3:
            setupLineChart(dictionary: summary.UserUsedCoupon!, title: "Used Coupons")
        default:
            fatalError("Segment control is out of index!")
        }
    }
    
    @IBAction func logoutUser(_ sender: UIBarButtonItem) {
        
        let adminDao = AdminDao()
        
        // delete from User Default
        adminDao.clearDataFromUserDefault()
        
        // redirct to login page
        let window = UIApplication.shared.keyWindow
        let storyboard
            = UIStoryboard(name: "Main", bundle: nil)
        let LoginVC = storyboard.instantiateViewController(withIdentifier: "loginVCNavigation")
        window?.rootViewController  = LoginVC
        UIView.transition(with: window!, duration: 0.5, options: .curveEaseInOut, animations: nil, completion: nil)
        
    }
    
    
}


extension AdminSummaryViewController: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        floatingLabelCenterConstraint?.constant = highlight.xPx
        floatingLabel.text = "  \(highlight.y)  "
        
        floatingLabel.isHidden = false
        floatingLabel.alpha = 0
        UIView.animate(withDuration: 1) {
            self.floatingLabel.alpha = 1
        }
    }
    
}

extension AdminSummaryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! SummaryCollectionViewCell
        
        let index = indexPath.row
        let value = (collectionView == dailyCollectionView) ? dailyArray[index] : monthlyArray[index]
        
        let data = SummaryCellModel(image: UIImage(named: "icon_\(index)")!, type: typeArray[index], value: "\(value)", details: unitArray[index])
        
        cell.configure(with: data)
        
        return cell
        
    }
    
}
