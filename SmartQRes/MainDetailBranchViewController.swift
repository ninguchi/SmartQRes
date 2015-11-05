//
//  MainDetailBranchViewController.swift
//  SmartQRes
//
//  Created by ninguchi on 3/7/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import UIKit

class MainDetailBranchViewController: UIViewController {
    
    @IBOutlet weak var imageRestaurant: UIImageView!
    @IBOutlet weak var labelBranchName: UILabel!
    var branchId:NSNumber = 0
    let instance = SingletonClass.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Main Detail Branch View Controller")
        var nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor(red: (254/255.0), green: (160/255.0), blue: (4/255.0), alpha: 1.0)
        nav?.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Heiti SC", size: 20)!, NSForegroundColorAttributeName: UIColor(red: (36/255.0), green: (17/255.0), blue: (0/255.0), alpha: 1.0)]
        nav?.tintColor = UIColor(red: (36/255.0), green: (17/255.0), blue: (0/255.0), alpha: 1.0)
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let branchId:NSNumber = prefs.integerForKey("BRANCHID") as NSNumber
        print("User branchid \(branchId)")
        self.branchId = branchId
        BranchController().getBranchNameById(self.branchId,uiView: self)
        //QueueController().getQueueById(0, uiView: self)
        //self.instance.pushItems()
        /*
        var cur = CurrentRunningNo()
        cur.cur_id = 1
        cur.cur_bra_id = 1
        cur.cur_ty_a = 4
        cur.cur_ty_b = 0
        cur.cur_ty_c = 0
        cur.cur_ty_d = 0
        CurrentRunningNoController().createItem(cur)
*/
        /*
        var shoppingMall = ShoppingMall()
        shoppingMall.sho_id = 4
        shoppingMall.sho_name = "Ladprao"
        ShoppingMallController().createItem(shoppingMall)
        var shoppingMall1 = ShoppingMall()
        shoppingMall1.sho_id = 5
        shoppingMall1.sho_name = "Bangna"
        ShoppingMallController().createItem(shoppingMall1)
        var shoppingMall2 = ShoppingMall()
        shoppingMall2.sho_id = 6
        shoppingMall2.sho_name = "Pinklao"
        ShoppingMallController().createItem(shoppingMall2)
        var shoppingMall3 = ShoppingMall()
        shoppingMall3.sho_id = 7
        shoppingMall3.sho_name = "Future Park Rangsit"
        ShoppingMallController().createItem(shoppingMall3)
        var shoppingMall4 = ShoppingMall()
        shoppingMall4.sho_id = 8
        shoppingMall4.sho_name = "Emporium"
        ShoppingMallController().createItem(shoppingMall4)
        var shoppingMall5 = ShoppingMall()
        shoppingMall5.sho_id = 9
        shoppingMall5.sho_name = "Central Rama 3"
        ShoppingMallController().createItem(shoppingMall5)
        var shoppingMall6 = ShoppingMall()
        shoppingMall6.sho_id = 10
        shoppingMall6.sho_name = "The Mall Bangkapi"
        ShoppingMallController().createItem(shoppingMall6)
        var shoppingMall7 = ShoppingMall()
        shoppingMall7.sho_id = 11
        shoppingMall7.sho_name = "The Mall Ngamwongwan"
        ShoppingMallController().createItem(shoppingMall7)
        var shoppingMall8 = ShoppingMall()
        shoppingMall8.sho_id = 12
        shoppingMall8.sho_name = "U-CHU-LIANG"
        ShoppingMallController().createItem(shoppingMall8)*/
        /*
        var queue = Queue()
        queue.que_id = 1
        queue.que_type = 2
        queue.que_bra_id = 1
        queue.que_cus_id = 1
        queue.que_status = 1
        queue.que_tb_type = "A"
        queue.que_no = 1
        queue.que_no_person = 4
        queue.que_child_flag = "N"
        queue.que_wheel_flag = "N"
        queue.que_confirm_code = ""
        queue.que_current_flag = "Y"
        QueueController().createItem(queue)
        print("Create Q")
        
        var queue1 = Queue()
        queue1.que_id = 2
        queue1.que_type = 2
        queue1.que_bra_id = 1
        queue1.que_cus_id = 1
        queue1.que_status = 1
        queue1.que_tb_type = "A"
        queue1.que_no = 2
        queue1.que_no_person = 3
        queue1.que_child_flag = "Y"
        queue1.que_wheel_flag = "N"
        queue1.que_confirm_code = ""
        queue1.que_current_flag = "N"
        QueueController().createItem(queue1)
        print("Create Q")
        
        var queue2 = Queue()
        queue2.que_id = 3
        queue2.que_type = 1
        queue2.que_bra_id = 1
        queue2.que_cus_id = 1
        queue2.que_status = 1
        queue2.que_tb_type = "A"
        queue2.que_no = 3
        queue2.que_no_person = 2
        queue2.que_child_flag = "N"
        queue2.que_wheel_flag = "N"
        queue2.que_confirm_code = "678564"
        queue2.que_current_flag = "N"
        QueueController().createItem(queue2)
        print("Create Q")
        
        var queue3 = Queue()
        queue3.que_id = 4
        queue3.que_type = 1
        queue3.que_bra_id = 1
        queue3.que_cus_id = 1
        queue3.que_status = 1
        queue3.que_tb_type = "A"
        queue3.que_no = 4
        queue3.que_no_person = 4
        queue3.que_child_flag = "N"
        queue3.que_wheel_flag = "Y"
        queue3.que_confirm_code = "678532"
        queue3.que_current_flag = "N"
        QueueController().createItem(queue3)
        print("Create Q")
        
        var queue4 = Queue()
        queue4.que_id = 5
        queue4.que_type = 1
        queue4.que_bra_id = 1
        queue4.que_cus_id = 1
        queue4.que_status = 1
        queue4.que_tb_type = "A"
        queue4.que_no = 5
        queue4.que_no_person = 1
        queue4.que_child_flag = "N"
        queue4.que_wheel_flag = "N"
        queue4.que_confirm_code = "773562"
        queue4.que_current_flag = "N"
        QueueController().createItem(queue4)
        print("Create Q")
        
        var queue5 = Queue()
        queue5.que_id = 6
        queue5.que_type = 1
        queue5.que_bra_id = 1
        queue5.que_cus_id = 1
        queue5.que_status = 1
        queue5.que_tb_type = "B"
        queue5.que_no = 1
        queue5.que_no_person = 8
        queue5.que_child_flag = "Y"
        queue5.que_wheel_flag = "N"
        queue5.que_confirm_code = "770561"
        queue5.que_current_flag = "Y"
        QueueController().createItem(queue5)
        print("Create Q")
        
        var queue6 = Queue()
        queue6.que_id = 7
        queue6.que_type = 2
        queue6.que_bra_id = 1
        queue6.que_cus_id = 1
        queue6.que_status = 1
        queue6.que_tb_type = "B"
        queue6.que_no = 2
        queue6.que_no_person = 10
        queue6.que_child_flag = "N"
        queue6.que_wheel_flag = "N"
        queue6.que_confirm_code = ""
        queue6.que_current_flag = "N"
        QueueController().createItem(queue6)
        print("Create Q")
        
        var queue7 = Queue()
        queue7.que_id = 8
        queue7.que_type = 2
        queue7.que_bra_id = 1
        queue7.que_cus_id = 1
        queue7.que_status = 1
        queue7.que_tb_type = "B"
        queue7.que_no = 3
        queue7.que_no_person = 12
        queue7.que_child_flag = "N"
        queue7.que_wheel_flag = "N"
        queue7.que_confirm_code = ""
        queue7.que_current_flag = "N"
        QueueController().createItem(queue7)
        print("Create Q")
*/
    //QueueController().getQueueById(1, uiView: self)
        /*
        var branch = Branch()
        branch.bra_id = 3
        branch.bra_name = "Ladprao"
        branch.bra_location = "3rd Floor Central Ladprao Phahonyotin Rd Ladprao Jatujak Bangkok 10900"
        branch.bra_sho_id = 1
        branch.bra_service_time = "10.30AM - 9.30PM"
        branch.bra_status = 1
        branch.bra_contact_no = "02-5411506,02-5411281"
        BranchController().createItem(branch)
        
        var branch1 = Branch()
        branch1.bra_id = 4
        branch1.bra_name = "Bangna"
        branch1.bra_location = "2nd Floor Central City Bangna Bangna-trad Rd Phakanong Bangna Bangkok 10260"
        branch1.bra_sho_id = 1
        branch1.bra_service_time = "10.30AM - 9.30PM"
        branch1.bra_status = 1
        branch1.bra_contact_no = "02-3610622,02-3610637"
        BranchController().createItem(branch1)
*//*
        var staff:UserStaff = UserStaff()
        staff.uss_id = 18
        staff.uss_bra_id = 1
        staff.uss_res_id = 3
        staff.uss_type = 1
        staff.uss_username = "Coco"
        staff.uss_password = "Coco"
        UserStaffController().createUserStaff(staff)*/
        //QueueController().getQueueById(1, uiView: self)
        /*
        var staff:UserStaff = UserStaff()
        staff.uss_id = 7
        staff.uss_bra_id = 7
        staff.uss_res_id = 1
        staff.uss_type = 2
        staff.uss_username = "staff07"
        staff.uss_password = "staff07"
        UserStaffController().createUserStaff(staff)
        
        var staff1:UserStaff = UserStaff()
        staff1.uss_id = 8
        staff1.uss_bra_id = 8
        staff1.uss_res_id = 1
        staff1.uss_type = 2
        staff1.uss_username = "staff08"
        staff1.uss_password = "staff08"
        //UserStaffController().createUserStaff(staff1)
        
        var staff2:UserStaff = UserStaff()
        staff2.uss_id = 9
        staff2.uss_bra_id = 9
        staff2.uss_res_id = 1
        staff2.uss_type = 2
        staff2.uss_username = "staff09"
        staff2.uss_password = "staff09"
        //UserStaffController().createUserStaff(staff2)
        
        var staff3:UserStaff = UserStaff()
        staff3.uss_id = 10
        staff3.uss_bra_id = 10
        staff3.uss_res_id = 1
        staff3.uss_type = 2
        staff3.uss_username = "staff10"
        staff3.uss_password = "staff10"
        //UserStaffController().createUserStaff(staff3)
        
        var staff4:UserStaff = UserStaff()
        staff4.uss_id = 11
        staff4.uss_bra_id = 1
        staff4.uss_res_id = 1
        staff4.uss_type = 2
        staff4.uss_username = "staff01"
        staff4.uss_password = "staff01"
       // UserStaffController().createUserStaff(staff4)*/
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
    }
    */

}
