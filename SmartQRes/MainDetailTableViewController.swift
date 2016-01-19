//
//  MainDetailTableViewController.swift
//  SmartQRes
//
//  Created by ninguchi on 3/14/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import UIKit

class MainDetailTableViewController: UITableViewController, UISplitViewControllerDelegate {
    var hideMaster:Bool = false


    override func viewDidLoad() {
        super.viewDidLoad()
        var nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor(red: (254/255.0), green: (160/255.0), blue: (4/255.0), alpha: 1.0)
        nav?.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Century Gothic", size: 20.0)!, NSForegroundColorAttributeName: UIColor(red: (36/255.0), green: (17/255.0), blue: (0/255.0), alpha: 1.0)]
        nav?.tintColor = UIColor(red: (36/255.0), green: (17/255.0), blue: (0/255.0), alpha: 1.0)
        // Left Bar Button
        let image:UIImage = UIImage(named: "menu_icon_re.png")!
        let hideButton = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: "hideTrigger")
        self.navigationItem.leftBarButtonItem = hideButton
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Century Gothic", size: 20)!], forState: UIControlState.Normal)
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


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
