//
//  ConfirmBookingViewController.swift
//  SmartQRes
//
//  Created by ninguchi on 1/4/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import UIKit

class ConfirmBookingViewController: UIViewController {

    @IBOutlet weak var labelQueueNo: UILabel!
    @IBOutlet weak var labelWaitTime: UILabel!
    @IBOutlet weak var labelRemainQ: UILabel!
    @IBOutlet weak var labelNumber: UILabel!
    @IBOutlet weak var btnDone: UIButton!
    
    var numberPerson : String = ""
    
    var currentQA : NSNumber = 0
    var currentQB : NSNumber = 0
    var currentQC : NSNumber = 0
    var currentQD : NSNumber = 0
    
    var branchObj : Branch = Branch()
    var queueObj : Queue = Queue()
    
    override func viewDidLoad() {
        //Set Remain Queue (By get the current queue (Flag == "Y")
        QueueController().getCurrentQueue(branchObj.bra_id, tb_type: queueObj.que_tb_type as String, uiView: self)
        
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        btnDone.layer.cornerRadius = 5
        
    }
    
    override func viewDidAppear(animated: Bool) {
        labelNumber.text = "\(self.queueObj.que_no_person)"
        labelQueueNo.text = "\(self.queueObj.que_tb_type)\(self.queueObj.que_no.integerValue.format(Constants.DecimalFormat.Queue))"
        
        QueueController().calculateRemainQAndWaitingTime(self)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
