//
//  BookingQViewController.swift
//  SmartQRes
//
//  Created by ninguchi on 1/1/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import UIKit

class BookingQViewController: UIViewController {

    @IBOutlet weak var switchChildren: UISwitch!
    @IBOutlet weak var switchWheelchair: UISwitch!
    @IBOutlet weak var labelNumber: UILabel!
    @IBOutlet weak var stepperNumber: UIStepper!
    @IBOutlet weak var btnConfirm: UIButton!
    
    var childrenFlag:Bool = false
    var wheelchairFlag:Bool = false
    
    var branchObj : Branch = Branch()
    var currentRunningNo : CurrentRunningNo = CurrentRunningNo()
    var queue : Queue = Queue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnConfirm.layer.cornerRadius = 5
        self.navigationItem.hidesBackButton = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func switchChildMethod(sender: AnyObject) {
        if switchChildren.on {
            childrenFlag = true
        }
        else {
            childrenFlag = false
        }
    }
    @IBAction func switchWheelMethod(sender: AnyObject) {
        if switchWheelchair.on {
            wheelchairFlag = true
        }
        else {
            wheelchairFlag = false
        }
    }
    
    
    @IBAction func stepNumber(sender: UIStepper) {
        labelNumber.text = Int(sender.value).description
    }

    @IBAction func confirmBookingMethod() {
        print("PRESS Confirm Button")
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let branchId:NSNumber = prefs.integerForKey("BRANCHID") as NSNumber
        
        let myString : String = self.labelNumber.text!
        let person: Int? = Int(myString)
        
        if (person != nil) {
            
            CurrentRunningNoController().getCurrentRunningNoByBraId(branchId, uiView: self)
            BranchController().getBranchById(branchId, uiView: self)
            NSThread.sleepForTimeInterval(0.5)
            QueueController().createQueue(branchId, noOfPerson: person!, childFlag: childrenFlag, wheelchairFlag: wheelchairFlag, branch: branchObj, crnObj: currentRunningNo, uiView: self)
            
        }
    }
    @IBAction func backToBookingQ(segue : UIStoryboardSegue){
        print("Back To Booking Q")
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        (segue.destinationViewController as! ConfirmBookingViewController).branchObj = self.branchObj
        (segue.destinationViewController as! ConfirmBookingViewController).queueObj = self.queue
        (segue.destinationViewController as! ConfirmBookingViewController).numberPerson = self.labelNumber.text!
        
        
    }

}
