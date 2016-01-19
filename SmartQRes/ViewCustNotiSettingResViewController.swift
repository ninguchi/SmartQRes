//
//  ViewCustNotiSettingResViewController.swift
//  SmartQRes
//
//  Created by ninguchi on 2/9/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import UIKit

class ViewCustNotiSettingResViewController: UIViewController {
    @IBOutlet weak var labelRound1: UILabel!
    @IBOutlet weak var labelRound2: UILabel!
    @IBOutlet weak var labelRound3: UILabel!
    var rest = Restaurant()
    var resId : NSNumber = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Set Navigation Bar
        var nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor(red: (254/255.0), green: (160/255.0), blue: (4/255.0), alpha: 1.0)
        nav?.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Century Gothic", size: 20)!, NSForegroundColorAttributeName: UIColor(red: (36/255.0), green: (17/255.0), blue: (0/255.0), alpha: 1.0)]
        nav?.tintColor = UIColor(red: (36/255.0), green: (17/255.0), blue: (0/255.0), alpha: 1.0)
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let resId:NSNumber = prefs.integerForKey("RESID") as NSNumber
        self.resId = resId
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        RestaurantController().getRestaurantById(self.resId,uiView: self)
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
        let editCustNotiSettingResViewController = segue.destinationViewController as! EditCustNotiSettingResViewController
        editCustNotiSettingResViewController.rest = self.rest
        editCustNotiSettingResViewController.round1 = labelRound1.text!
        editCustNotiSettingResViewController.round2 = labelRound2.text!
        editCustNotiSettingResViewController.round3  = labelRound3.text!
    }
    

}
