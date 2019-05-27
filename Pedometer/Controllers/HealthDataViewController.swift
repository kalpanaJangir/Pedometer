//
//  HealthDataViewController.swift
//  Pedometer
//
//  Created by kalpana on 26/05/19.
//  Copyright © 2019 kalpana. All rights reserved.
//

import UIKit

class HealthDataViewController: UIViewController {
    @IBOutlet var viewSteps: UIView!
    @IBOutlet var viewDistance: UIView!
    @IBOutlet var lblNoOfSteps: UILabel!
    @IBOutlet var lblDistance: UILabel!
    @IBOutlet var lblDateForSteps: UILabel!
    @IBOutlet var lblDateForDistance: UILabel!
    let kmInSteps:Double = 0.0008
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        setActivityHistory()
    }
    
    func setActivityHistory()
    {
        viewSteps.layer.cornerRadius = 5;
        viewSteps.layer.masksToBounds = true;
        viewDistance.layer.cornerRadius = 5;
        viewDistance.layer.masksToBounds = true;
        let strSteps = UserDefaults.standard.object(forKey:"NoOfSteps") as? String
        if (strSteps != nil)
        {
            lblNoOfSteps.text =  strSteps
        }
        else
        {
            lblNoOfSteps.text =  "0"
        }
        lblDateForSteps.text = UserDefaults.standard.object(forKey:"endDate") as? String
        lblDateForDistance.text = UserDefaults.standard.object(forKey:"endDate") as? String
        if (UserDefaults.standard.object(forKey:"NoOfSteps") != nil)
        {
            let a:Double? = Double((UserDefaults.standard.object(forKey:"NoOfSteps") as? String)!)
            lblDistance.text = String(format: "%.02f", (a!*kmInSteps))
        }
        else
        {
            lblDistance.text = String(format:"0")
        }
        
    }
    
}
