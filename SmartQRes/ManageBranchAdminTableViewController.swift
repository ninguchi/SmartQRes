//
//  ManageBranchAdminTableViewController.swift
//  SmartQRes
//
//  Created by ninguchi on 3/14/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import UIKit

class ManageBranchAdminTableViewController: UITableViewController {
    var adminList : [UserStaff] = []
    var branch : Branch = Branch()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        //UserStaffController().getUserStaffListByBraId(self.branch.bra_id, uiView: self)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        UserStaffController().getUserStaffListByBraId(self.branch.bra_id, uiView: self)
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
        return adminList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...
        cell.textLabel!.text = adminList[indexPath.row].uss_username as String
        cell.textLabel!.font = UIFont(name: "Century Gothic", size: 15)
        return cell
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }


    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let deleteAlert = UIAlertController(title: "Delete", message: "\nUsername '\(adminList[indexPath.row].uss_username)' will be deleted.", preferredStyle: UIAlertControllerStyle.Alert)

            deleteAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
                let userStaff = self.adminList[indexPath.row]
                self.adminList.removeAtIndex(indexPath.row)
                
                UserStaffController().deleteUserStaff(userStaff)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }))
            
            deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            
            self.presentViewController(deleteAlert, animated: true, completion: nil)
            
            
        }
    }
    

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
        if (segue.identifier == "viewBranchAdminResSegue"){
            print("View Branch Admin Res Regue")
            let indexPath = self.tableView!.indexPathForSelectedRow!
            var userStaff = adminList[indexPath.row] as UserStaff
            let viewBranchAdminViewController = segue.destinationViewController as! ViewBranchAdminViewController
            viewBranchAdminViewController.selectedUser = userStaff
            viewBranchAdminViewController.branch = branch
            print("Select Branch :\(userStaff.uss_id) and name : \(userStaff.uss_username)")
        }else{
            print("Add Branch Admin Res Segue")
            let addBranchAdminViewController = segue.destinationViewController as! AddBranchAdminViewController
            addBranchAdminViewController.branch = branch
        }
    }
    

}
