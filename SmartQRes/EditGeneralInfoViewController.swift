//
//  EditGeneralInfoViewController.swift
//  SmartQRes
//
//  Created by ninguchi on 2/9/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import UIKit

class EditGeneralInfoViewController: UIViewController, UIPopoverPresentationControllerDelegate  {
    //Outlet
    @IBOutlet weak var txtBranchName: UITextField!
    @IBOutlet weak var txtBranchLocation: UITextField!
    @IBOutlet weak var btnMall: UIButton!
    @IBOutlet weak var txtServiceTime: UITextField!
    @IBOutlet weak var btnBranchStatus: UIButton!
    @IBOutlet weak var txtContactNo: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    // Variable
    var selectStatus : String = ""
    var selectStatusId : Int = 0
    var selectMall : String = ""
    var selectMallId : Int = 0
    
    var name:String = ""
    var branchLocation:String = ""
    var shoppingMall:String = ""
    var branchTime:String = ""
    var branchStatus:String = ""
    var branchContactNo:String = ""
    var editBranch = Branch()
    let instance = SingletonClass.shared
    
    var branchId:NSNumber=0
    var isDuplicate = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Main Detail View Controller")
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let branchId:NSNumber = prefs.integerForKey("BRANCHID") as NSNumber
        self.branchId = branchId
        // Do any additional setup after loading the view.
        btnSave.layer.cornerRadius = 5
        txtBranchName!.text = name
        txtBranchLocation!.text = branchLocation
        btnMall.titleLabel!.text =  shoppingMall
        txtServiceTime!.text = branchTime
        btnBranchStatus.titleLabel!.text =  branchStatus
        txtContactNo!.text = branchContactNo
    }

    @IBAction func popoverMallsList(sender: AnyObject) {
        let v = sender as! UIView
        let vc = storyboard?.instantiateViewControllerWithIdentifier("MallListTableViewController") as! UITableViewController
        vc.modalPresentationStyle = .Popover
        vc.preferredContentSize = CGSizeMake(250, 300)
        self.presentViewController(vc, animated: true, completion: nil)
        if let pop = vc.popoverPresentationController {
            pop.sourceView = v
            pop.permittedArrowDirections = .Any
            pop.sourceRect = CGRect(x: 150, y: 10, width: 0, height: 0)
            pop.delegate = self
            // not working here either
            //pop.popoverLayoutMargins = UIEdgeInsetsMake(15, 20, 30, 40)
        }
    }

    @IBAction func popoverBranchStatusList(sender: AnyObject) {
        let v = sender as! UIView
        let vc = storyboard?.instantiateViewControllerWithIdentifier("BranchStatusListTableViewController") as! UITableViewController
        vc.modalPresentationStyle = .Popover
        vc.preferredContentSize = CGSizeMake(250, 200)
        self.presentViewController(vc, animated: true, completion: nil)
        if let pop = vc.popoverPresentationController {
            pop.sourceView = v
            pop.permittedArrowDirections = .Any
            pop.sourceRect = CGRect(x: 150, y: 10, width: 0, height: 0)
            pop.delegate = self
            // not working here either
            //pop.popoverLayoutMargins = UIEdgeInsetsMake(15, 20, 30, 40)
        }
    }
    
    @IBAction func selectMall(segue: UIStoryboardSegue){
        print("Select Mall \(selectMall)")
        btnMall.titleLabel!.text =  selectMall
    }
    
    @IBAction func selectBranchStatus(segue: UIStoryboardSegue){
        print("Select Branch \(selectStatus)")
        btnBranchStatus.titleLabel!.text = selectStatus
    }
    @IBAction func saveGeneralInfo() {
        //editBranch = self.instance.branchController.branch
        //editBranch.bra_id = self.branchId
        editBranch.bra_name = self.txtBranchName.text! 
        editBranch.bra_location = self.txtBranchLocation.text!
        if (selectMallId != 0){
            editBranch.bra_sho_id = selectMallId
        }
        editBranch.bra_service_time = self.txtServiceTime.text!
        if (selectStatusId != 0){
            editBranch.bra_status = selectStatusId
        }
        editBranch.bra_contact_no = self.txtContactNo.text!
        //self.instance.branchController.updateItem(editBranch)
        BranchController().checkDuplicateBranchName(editBranch, uiView: self)
        NSThread.sleepForTimeInterval(0.5)
        if(!isDuplicate){
            BranchController().updateItem(editBranch)
            NSThread.sleepForTimeInterval(0.5)
            self.navigationController?.popViewControllerAnimated(true)
        }else{
            let alertController = UIAlertController(title: "Update Error", message:
                "\nCannot update branch. The branch name has already exist.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
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
