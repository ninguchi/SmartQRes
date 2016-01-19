//
//  MainDetailViewController.swift
//  SmartQRes
//
//  Created by ninguchi on 1/1/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import UIKit

class MainDetailViewController: UIViewController , UISplitViewControllerDelegate {
    //Variable
    var hideMaster:Bool = false
    //var branchId:NSNumber = 0
    override func viewDidLoad() {
        super.viewDidLoad()/*
        // Retreive Branch ID
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let branchId:NSNumber = prefs.integerForKey("BRANCHID") as NSNumber
        print("User branchid \(branchId)")
        self.branchId = branchId*/
        
        // Do any additional setup after loading the view.
        var nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor(red: (254/255.0), green: (160/255.0), blue: (4/255.0), alpha: 1.0)
        nav?.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Century Gothic", size: 20)!, NSForegroundColorAttributeName: UIColor(red: (36/255.0), green: (17/255.0), blue: (0/255.0), alpha: 1.0)]
        nav?.tintColor = UIColor(red: (36/255.0), green: (17/255.0), blue: (0/255.0), alpha: 1.0)
        // Left Bar Button
        let image:UIImage = UIImage(named: "menu_icon_re.png")!
        let hideButton = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: "hideTrigger")
        // let hideButton = UIBarButtonItem(title: "Hide", style: UIBarButtonItemStyle.Plain, target: self, action: "hideTrigger")
        self.navigationItem.leftBarButtonItem = hideButton
        //self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Century Gothic", size: 20)!], forState: UIControlState.Normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func hideTrigger() {
        self.hideMaster = !self.hideMaster
        var spv:UISplitViewController = self.splitViewController!
        spv.view.setNeedsLayout()
        spv.delegate = nil;
        spv.delegate = self;
        spv.willRotateToInterfaceOrientation(self.interfaceOrientation, duration: 0)
    }
    
    func splitViewController(svc: UISplitViewController, shouldHideViewController vc: UIViewController, inOrientation orientation: UIInterfaceOrientation) -> Bool {
        return self.hideMaster
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
