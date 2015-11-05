//
//  EditBranchViewController.swift
//  SmartQRes
//
//  Created by ninguchi on 1/7/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import UIKit

class EditBranchViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    // Outlet
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
    var branch:Branch = Branch()
    var rest:Restaurant = Restaurant()
    
    var resId : NSNumber = 0
    var isDuplicate = true
    override func viewDidLoad() {
        super.viewDidLoad()
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let resId:NSNumber = prefs.integerForKey("RESID") as NSNumber
        self.resId = resId
        RestaurantController().getRestaurantById(resId, uiView : self)
        // Do any additional setup after loading the view.
        btnSave.layer.cornerRadius = 5
        //self.navigationItem.hidesBackButton = true
        
        if branch.bra_id != 0{
            txtBranchName!.text = name
            txtBranchLocation!.text = branchLocation
            btnMall.titleLabel!.text = shoppingMall
            txtServiceTime!.text = branchTime
            btnBranchStatus.titleLabel?.text = branchStatus
            txtContactNo!.text = branchContactNo
        }else{
            print("Current Res Id : \(self.resId)")
            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            let resId:NSNumber = prefs.integerForKey("RESID") as NSNumber
            self.resId =  resId
            print("User resid \(self.resId)")
            btnMall.titleLabel!.text = "---- Please Select ----"
            btnBranchStatus.titleLabel!.text = "---- Please Select ----"
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func popoverMallList(sender: AnyObject) {
        let v = sender as! UIView
        let vc = storyboard?.instantiateViewControllerWithIdentifier("MallListResTableViewController") as! UITableViewController
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
        let vc = storyboard?.instantiateViewControllerWithIdentifier("BranchStatusListResTableViewController") as! UITableViewController
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
    
    @IBAction func selectMallRes(segue: UIStoryboardSegue){
        print("Select Mall \(selectMall)")
        btnMall.titleLabel!.text = selectMall
    }
    
    @IBAction func selectBranchStatusRes(segue: UIStoryboardSegue){
        print("Select Branch \(selectStatus)")
        btnBranchStatus.titleLabel!.text = selectStatus
    }
    

    @IBAction func saveBranchInfo() {
        self.branch.bra_name = self.txtBranchName.text!
        self.branch.bra_location = self.txtBranchLocation.text!
        if(selectMallId != 0) {
            self.branch.bra_sho_id = selectMallId
        }
        self.branch.bra_service_time = self.txtServiceTime.text!
        if(selectStatusId != 0) {
            self.branch.bra_status = selectStatusId
        }
        self.branch.bra_contact_no = self.txtContactNo.text!
        if self.branch.bra_id == 0 {
            print("---- Create Branch -----")
            self.branch.bra_res_id = self.resId
            self.branch.bra_res_name = self.rest.res_name
            self.branch.bra_noti_1 = self.rest.res_noti_1
            self.branch.bra_noti_2 = self.rest.res_noti_2
            self.branch.bra_noti_3 = self.rest.res_noti_3
            BranchController().checkDuplicateBranchName(self.branch, uiView: self)
            NSThread.sleepForTimeInterval(0.5)
            if(!isDuplicate){
                BranchController().createItem(self.branch)
                //NSThread.sleepForTimeInterval(0.5)
                self.navigationController?.popViewControllerAnimated(true)
            }else{
                let alertController = UIAlertController(title: "Create Error", message:
                    "\nCannot create branch. The branch name has already exist.", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }else{
            print("---- Update Branch -----")
            BranchController().checkDuplicateBranchName(self.branch, uiView: self)
            NSThread.sleepForTimeInterval(0.5)
            if(!isDuplicate){
                BranchController().updateItem(self.branch)
                //NSThread.sleepForTimeInterval(0.5)
                self.navigationController?.popViewControllerAnimated(true)
            }else{
                let alertController = UIAlertController(title: "Update Error", message:
                    "\nCannot update branch. The branch name has already exist.", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
        print("Save Branch Info \(branch.bra_id) \(branch.bra_name) \(branch.bra_location) \(branch.bra_sho_id) \(branch.bra_service_time) \(branch.bra_status) \(branch.bra_contact_no)")
        //var nav = self.navigationController?.navigationBar
        
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
