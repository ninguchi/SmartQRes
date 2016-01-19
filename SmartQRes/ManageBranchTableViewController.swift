//
//  ManageBranchTableViewController.swift
//  SmartQRes
//
//  Created by ninguchi on 1/7/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import UIKit

class ManageBranchTableViewController: UITableViewController {
    var branchList: [Branch] = []
    var resId : NSNumber = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Current Res Id : \(self.resId)")
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let resId:NSNumber = prefs.integerForKey("RESID") as NSNumber
        self.resId =  resId
        print("User resid \(self.resId)")
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewDidAppear(animated: Bool) {
         super.viewDidAppear(true)
        BranchController().getBranchListByResId(self.resId, uiView: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return branchList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        cell.textLabel!.text = branchList[indexPath.row].bra_name as String
        cell.textLabel!.font = UIFont(name: "Century Gothic", size: 15)
        return cell
    }
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        //editBranchInfoResSegue
        if segue.identifier == "manageBranchMainResSegue" {
            let indexPath = self.tableView!.indexPathForSelectedRow!
            var branch = branchList[indexPath.row] as Branch
            let manageBranchViewController = segue.destinationViewController as! ManageBranchViewController
            manageBranchViewController.selectedBranch = branch
            print("Select Branch :\(branch.bra_id) and name : \(branch.bra_name)")
        }else{
            print("Add New Branch")
        }
    }
}
