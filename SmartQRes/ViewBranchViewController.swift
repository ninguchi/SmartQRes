//
//  ViewBranchViewController.swift
//  SmartQRes
//
//  Created by ninguchi on 1/7/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import UIKit

class ViewBranchViewController: UIViewController {
    @IBOutlet weak var labelBranchName: UILabel!
    @IBOutlet weak var labelBranchLocation: UILabel!
    @IBOutlet weak var labelShoppingMall: UILabel!
    @IBOutlet weak var labelBranchTime: UILabel!
    @IBOutlet weak var labelBranchStatus: UILabel!
    @IBOutlet weak var labelBranchContactNo: UILabel!
    
    var branch : Branch = Branch()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        BranchController().getBranchById(self.branch.bra_id,uiView: self)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        BranchController().getBranchById(self.branch.bra_id,uiView: self)
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
         if(segue.identifier == "editBranchGeneralResSegue"){
            let editBranchViewController = segue.destinationViewController as! EditBranchViewController
            editBranchViewController.branch = self.branch
            editBranchViewController.name = labelBranchName.text!
            editBranchViewController.branchLocation = labelBranchLocation.text!
            editBranchViewController.shoppingMall = labelShoppingMall.text!
            editBranchViewController.branchTime = labelBranchTime.text!
            editBranchViewController.branchStatus = labelBranchStatus.text!
            editBranchViewController.branchContactNo = labelBranchContactNo.text!
        }
    }
    

}
