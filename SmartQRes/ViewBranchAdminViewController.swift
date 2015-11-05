//
//  ViewBranchAdminViewController.swift
//  SmartQRes
//
//  Created by ninguchi on 3/14/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import UIKit

class ViewBranchAdminViewController: UIViewController {
    
    @IBOutlet weak var branchName: UILabel!
    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelPassword: UILabel!


    var selectedUser = UserStaff()
    var branch = Branch()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.branchName.text! = self.branch.bra_name as String
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        UserStaffController().getUserStaffInfo(selectedUser.uss_id, uiView: self)

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
        let editBranchAdminViewController = segue.destinationViewController as! EditBranchAdminViewController
        editBranchAdminViewController.selectedUser = selectedUser
        editBranchAdminViewController.branch = branch
    }
    

}
