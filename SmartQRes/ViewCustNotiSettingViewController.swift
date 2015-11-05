//
//  ViewCustNotiSettingViewController.swift
//  SmartQRes
//
//  Created by ninguchi on 2/9/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import UIKit

class ViewCustNotiSettingViewController: UIViewController {
    @IBOutlet weak var labelRound1: UILabel!
    @IBOutlet weak var labelRound2: UILabel!
    @IBOutlet weak var labelRound3: UILabel!

    var branchId:NSNumber = 0
    var editBranch = Branch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("View Cust Noti Setting View Controller")
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let branchId:NSNumber = prefs.integerForKey("BRANCHID") as NSNumber
        print("User branchid \(branchId)")
        self.branchId = branchId
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        BranchController().getBranchById(self.branchId,uiView: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let editCustNotiSettingViewController = segue.destinationViewController as! EditCustNotiSettingViewController
        editCustNotiSettingViewController.round1 = labelRound1.text!
        editCustNotiSettingViewController.round2 = labelRound2.text!
        editCustNotiSettingViewController.round3  = labelRound3.text!
        editCustNotiSettingViewController.editBranch = self.editBranch
    }
    

}
