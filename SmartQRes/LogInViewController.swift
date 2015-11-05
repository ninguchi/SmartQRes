//
//  LogInViewController.swift
//  SmartQRes
//
//  Created by ninguchi on 1/1/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate, CDTReplicatorDelegate {
    
    //let instance = SingletonClass.shared
    let userStaff = UserStaffController()
    
    var labelLogin = ""
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btnLoginBranch: UIButton!
    @IBOutlet weak var btnCencel: UIButton!
    @IBOutlet weak var LoginView: UIView!
    
    var frameView: UIView!
    
    var isShow = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLoginBranch.layer.cornerRadius = 5
        btnCencel.layer.cornerRadius = 5
        
        self.frameView = LoginView//UIView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height))
        
        // Keyboard stuff.
        //var center: NSNotificationCenter = NSNotificationCenter.defaultCenter()
        //center.addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        //center.addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    func keyboardWillShow(notification: NSNotification) {
        if(!isShow){
        var info:NSDictionary = notification.userInfo!
        var keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        
        var keyboardHeight:CGFloat = keyboardSize.height
        
        var animationDuration:CGFloat = info[UIKeyboardAnimationDurationUserInfoKey] as! CGFloat
        
        UIView.animateWithDuration(0.25, delay: 0.25, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.frameView.frame = CGRectMake(0, (self.frameView.frame.origin.y - keyboardHeight) + 100  , self.view.bounds.width, self.view.bounds.height)
            }, completion: nil)
            isShow = true
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        var info:NSDictionary = notification.userInfo!
        var keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        
        var keyboardHeight:CGFloat = keyboardSize.height
        
        var animationDuration:CGFloat = info[UIKeyboardAnimationDurationUserInfoKey] as! CGFloat
        
        UIView.animateWithDuration(0.25, delay: 0.25, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.frameView.frame = CGRectMake(0, (self.frameView.frame.origin.y + keyboardHeight) - 100, self.view.bounds.width, self.view.bounds.height)
            }, completion: nil)
        isShow = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }*/
    /*
    func textFieldDidBeginEditing(textField:UITextField){
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.25)
        var frame:CGRect = self.view.frame;
        frame.origin.y = frame.origin.y - 204;
        self.view.frame = frame
        UIView.commitAnimations()
    }*/
    
    @IBAction func hideKB(sender: AnyObject) {
        txtUsername.resignFirstResponder()
        txtPassword.resignFirstResponder()
    }
    
    @IBAction func logout(segue: UIStoryboardSegue){
        print("Back to Main Login Page")
    }
    
    
    @IBAction func cancelMethod() {
        txtUsername.text = ""
        txtPassword.text = ""
        //self.dismissViewControllerAnimated(false, completion: nil)
    }

    @IBAction func loginAsBranchAdminMethod() {
        userStaff.getAuthenStaff(txtUsername.text!,password: txtPassword.text!, uiView : self)
        self.dismissViewControllerAnimated(true, completion: nil)
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
