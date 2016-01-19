//
//  OrderListViewController.swift
//  SmartQRes
//
//  Created by Kewalin Sakawattananon on 11/25/2558 BE.
//  Copyright © 2558 BlueSeed. All rights reserved.
//

import UIKit

class OrderListViewController: UIViewController {
    var status = 0
    var btnTitle = "Confirm Order"
    var queueInfo = ""
    var queueNo = ""
    @IBOutlet weak var txtQueueInfo:UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = queueNo
        if status == 0 {
            btnTitle = "Done"
            txtQueueInfo.text = queueInfo
        }else{
            txtQueueInfo.text = queueInfo
            var editItem = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: "confirmBtnTapped")
            self.navigationItem.leftBarButtonItem = editItem
        }
        txtQueueInfo.font = UIFont.systemFontOfSize(15)
        // Do any additional setup after loading the view.
        var confirmItem = UIBarButtonItem(title: btnTitle, style: .Plain, target: self, action: "confirmBtnTapped")
        /*
        if let font = customFont {
            continueItem.setTitleTextAttributes([NSFontAttributeName: font], forState: UIControlState.Normal)}
        continueItem.tintColor = UIColor.whiteColor()*/
        self.navigationItem.rightBarButtonItem = confirmItem

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func confirmBtnTapped(){
        self.dismissViewControllerAnimated(true, completion: nil)
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
