//
//  ViewController.swift
//  Pedometer
//
//  Created by kalpana on 23/05/19.
//  Copyright © 2019 kalpana. All rights reserved.
//

import UIKit
import CoreMotion
private let activityManager = CMMotionActivityManager()
private let pedometer = CMPedometer()
class ViewController: UIViewController {
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var lblStepsCount: UILabel!
    @IBOutlet var lblActivityType: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startUpdating()
        
    }
    
    //method for tracking activity events
    private func startTrackingActivityType() {
        activityManager.startActivityUpdates(to: OperationQueue.main) {
            [weak self] (activity: CMMotionActivity?) in
            
            guard let activity = activity else { return }
            DispatchQueue.main.async {
                self?.lblTime.text =  self?.dateToString(inputDate: activity.startDate) as String?
                if activity.walking {
                    self?.lblActivityType.text = "Walking"
                } else if activity.stationary {
                    self?.lblActivityType.text = "Stationary"
                } else if activity.running {
                    self?.lblActivityType.text = "Running"
                } else if activity.automotive {
                    self?.lblActivityType.text = "Automotive"
                }
                
            }
        }
    }
    
    // method for counting steps
    private func startCountingSteps() {
        pedometer.startUpdates(from: Date()) {
            [weak self] pedometerData, error in
            guard let pedometerData = pedometerData, error == nil else { return }
            
            UserDefaults.standard.set(pedometerData.numberOfSteps.stringValue, forKey: "NoOfSteps")
            UserDefaults.standard.set(self?.dateToString(inputDate:pedometerData.endDate) as String?, forKey: "endDate")
            DispatchQueue.main.async {
                self?.lblStepsCount.text = pedometerData.numberOfSteps.stringValue
            }
        }
    }
    
    private func startUpdating() {
        if CMMotionActivityManager.isActivityAvailable() {
            startTrackingActivityType()
        }
        
        if CMPedometer.isStepCountingAvailable() {
            startCountingSteps()
        }
    }
    
    // converting date into string type
    func dateToString(inputDate: Date) -> NSString {
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: inputDate) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "EEEE dd MMM yyyy"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        return myStringafd as NSString
    }

}

