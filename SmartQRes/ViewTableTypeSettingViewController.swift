//
//  ViewTableTypeSettingViewController.swift
//  SmartQRes
//
//  Created by ninguchi on 2/9/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import UIKit

class ViewTableTypeSettingViewController: UIViewController {

    @IBOutlet weak var labelAMax: UILabel!
    @IBOutlet weak var labelBMax: UILabel!
    @IBOutlet weak var labelCMax: UILabel!
    @IBOutlet weak var labelDMax: UILabel!
    @IBOutlet weak var labelATurnOver: UILabel!
    @IBOutlet weak var labelBTurnOver: UILabel!
    @IBOutlet weak var labelCTurnOver: UILabel!
    @IBOutlet weak var labelDTurnOver: UILabel!
    
    var branchId:NSNumber = 0
    var editBranch = Branch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("View Table Type Setting View Controller")
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
        let editTableTypeViewController = segue.destinationViewController as! EditTableTypeSettingViewController
        editTableTypeViewController.AMax = labelAMax.text!
        editTableTypeViewController.BMax = labelBMax.text!
        editTableTypeViewController.CMax = labelCMax.text!
        editTableTypeViewController.DMax = labelDMax.text!
        editTableTypeViewController.ATurnOver = labelATurnOver.text!
        editTableTypeViewController.BTurnOver = labelBTurnOver.text!
        editTableTypeViewController.CTurnOver = labelCTurnOver.text!
        editTableTypeViewController.DTurnOver = labelDTurnOver.text!
        editTableTypeViewController.editBranch = self.editBranch
    }
    

}