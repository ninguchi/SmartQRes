//
//  ViewGeneralInfoViewController.swift
//  SmartQRes
//
//  Created by ninguchi on 2/9/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import UIKit

class ViewGeneralInfoViewController: UIViewController {


    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelBranchLocation: UILabel!
    @IBOutlet weak var labelShoppingMall: UILabel!
    @IBOutlet weak var labelBranchTime: UILabel!
    @IBOutlet weak var labelBranchStatus: UILabel!
    @IBOutlet weak var labelBranchContactNo: UILabel!
    
    var itemList: [Branch] = []
    var filteredListItems = [Branch]()
    
    var idTracker = 0
    
    // Cloud sync properties
    var dbName:String = "smartqdb"
    var datastore: CDTStore!
    var remoteStore: CDTStore!
    
    var replicatorFactory: CDTReplicatorFactory!
    
    var pullReplication: CDTPullReplication!
    var pullReplicator: CDTReplicator!
    
    var pushReplication: CDTPushReplication!
    var pushReplicator: CDTReplicator!
    
    var doingPullReplication: Bool!
    
    var branchId:NSNumber = 0
    var editBranch = Branch()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("View General Info View Controller")
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
        let editGeneralInfoViewController = segue.destinationViewController as! EditGeneralInfoViewController
        editGeneralInfoViewController.name = labelName.text!
        editGeneralInfoViewController.branchLocation = labelBranchLocation.text!
        editGeneralInfoViewController.shoppingMall = labelShoppingMall.text!
        editGeneralInfoViewController.branchTime = labelBranchTime.text!
        editGeneralInfoViewController.branchStatus = labelBranchStatus.text!
        editGeneralInfoViewController.branchContactNo = labelBranchContactNo.text!
        editGeneralInfoViewController.editBranch = self.editBranch
        
    }
    

}
