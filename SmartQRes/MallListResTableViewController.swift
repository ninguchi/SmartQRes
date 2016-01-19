//
//  MallListResTableViewController.swift
//  SmartQRes
//
//  Created by ninguchi on 2/9/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import UIKit

class MallListResTableViewController: UITableViewController {

    var shoppingMallList : [ShoppingMall] = []
    var filteredListItems = [ShoppingMall]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ShoppingMallController().getShoppingMallList(self)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
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
        return self.shoppingMallList.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        var shopping = self.shoppingMallList[indexPath.row] as ShoppingMall
        cell.textLabel!.text = shopping.sho_name as String
        cell.textLabel!.font = UIFont(name: "Century Gothic", size: 14)
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var row = indexPath.row
        print("row = \(row)")
        self.dismissViewControllerAnimated(false, completion: nil)
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
        let indexPath = self.tableView!.indexPathForSelectedRow!
        var shopping = shoppingMallList[indexPath.row] as ShoppingMall
        (segue.destinationViewController as! EditBranchViewController).selectMall = shopping.sho_name as String
        (segue.destinationViewController as! EditBranchViewController).selectMallId = shopping.sho_id as Int
    }
}
