//
//  ManageBranchViewController.swift
//  SmartQRes
//
//  Created by ninguchi on 3/14/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import UIKit

class ManageBranchViewController: UIViewController {
    
    var selectedBranch:Branch = Branch()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        if segue.identifier == "manageBranchAdminResSegue"{
            print("Manage Branch Admin Res Segue")
            let manageBranchAdminTableViewController = segue.destinationViewController as! ManageBranchAdminTableViewController
            manageBranchAdminTableViewController.branch = selectedBranch
        }else if segue.identifier == "viewBranchGeneralResSegue"{
            let viewBranchViewController = segue.destinationViewController as! ViewBranchViewController
            viewBranchViewController.branch = selectedBranch
            
        }
        
    }
    

}
