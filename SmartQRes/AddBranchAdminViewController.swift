//
//  AddBranchAdminViewController.swift
//  SmartQRes
//
//  Created by ninguchi on 3/14/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import UIKit

class AddBranchAdminViewController: UIViewController {
    @IBOutlet weak var labelBranchName: UILabel!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    var userStaff = UserStaff()
    var branch = Branch()
    var isDuplicate = true
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSave.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
        labelBranchName.text! = branch.bra_name as String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func saveMethod() {
        print("New Password from Txt box \(txtPassword.text!)")
        print("New Confirm Password from Txt box \(txtConfirmPassword.text!)")
        
        if(txtPassword.text! == txtConfirmPassword.text! && txtConfirmPassword.text!.characters.count != 0){
            userStaff.uss_username = txtUsername.text!
            userStaff.uss_password = txtPassword.text!
            userStaff.uss_bra_id = branch.bra_id
            userStaff.uss_res_id = branch.bra_res_id
            userStaff.uss_type = Constants.AdminType.Branch
            UserStaffController().checkDuplicateUserName(userStaff, uiView: self)
            NSThread.sleepForTimeInterval(0.5)
            if(!isDuplicate){
                UserStaffController().createUserStaff(userStaff)
                self.navigationController?.popViewControllerAnimated(true)
            }else{
                let alertController = UIAlertController(title: "Create Error", message:
                    "\nCannot create user. The username has already exist.", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }else{
            //Show error popup
            self.errorPopup()
        }
        
    }
    
    func errorPopup(){
        let alert = UIAlertView()
        alert.title = "Incorrect Password"
        alert.message = "Please try again."
        alert.addButtonWithTitle("OK")
        alert.show()
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
