//
//  WelcomeViewController.swift
//  SmartQRes
//
//  Created by Kamnung Pitukkorn on 2/13/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    var dbName:String = "smartqdb"
    var itemList: [UserStaff] = []
    var filteredListItems = [UserStaff]()
    var datastore: CDTStore!
    var remoteStore: CDTStore!
    
    var replicatorFactory: CDTReplicatorFactory!
    
    var pullReplication: CDTPullReplication!
    var pullReplicator: CDTReplicator!
    
    var pushReplication: CDTPushReplication!
    var pushReplicator: CDTReplicator!
    
    var doingPullReplication: Bool!
    var queryPredicate:NSPredicate!
    
    var resid:NSNumber = 0
    var branchid:NSNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDomain = NSBundle.mainBundle().bundleIdentifier
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let isLoggedIn:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        if (isLoggedIn != 1) {
            self.performSegueWithIdentifier("loginSegue", sender: self)
        } else {
            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            let isAuthen:Bool = prefs.boolForKey("AUTHEN") as Bool
            if (isAuthen){
                let user_type = prefs.valueForKey("USERTYPE") as! NSNumber
                if (user_type==2){
                    branchid = prefs.valueForKey("BRANCHID") as! NSNumber
                    self.performSegueWithIdentifier("branchHomeSegue", sender: self)
                }
                else{
                    resid = prefs.valueForKey("RESID") as! NSNumber
                    self.performSegueWithIdentifier("restaurantHomeSegue", sender: self)
                }
                //self.txtUsername.text = prefs.valueForKey("USERNAME") as NSString
            }else{
                let alert = UIAlertView()
                alert.title = "Authen"
                alert.message = "This is incorrect"
                alert.addButtonWithTitle("Ok")
                alert.show()
                self.performSegueWithIdentifier("loginSegue", sender: self)
            }
            
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
        print("Prepare for segue")
        if (segue.identifier == "branchHomeSegue") {
            // pass data to next view
            print("Branch Home");
            print("Branch ID : \(branchid)")
            (segue.destinationViewController as BranchSplitViewController).curBranchId = branchid
         }
    }
    */

}
