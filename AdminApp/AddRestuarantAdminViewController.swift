//
//  AddRestuarantAdminViewController.swift
//  AdminApp
//
//  Created by Nesma Tharwat on 6/23/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit

class AddRestuarantAdminViewController: UIViewController {
    @IBOutlet weak var restuarantImageView: UIImageView!
    
    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
