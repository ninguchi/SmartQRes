//
//  EditCustNotiSettingResViewController.swift
//  SmartQRes
//
//  Created by ninguchi on 2/9/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import UIKit

class EditCustNotiSettingResViewController: UIViewController {
    @IBOutlet weak var txtRound1: UITextField!
    @IBOutlet weak var txtRound2: UITextField!
    @IBOutlet weak var txtRound3: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    //Variable
    var round1:String = ""
    var round2:String = ""
    var round3:String = ""
    
    var rest = Restaurant()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Set Navigation Bar
        var nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor(red: (254/255.0), green: (160/255.0), blue: (4/255.0), alpha: 1.0)
        nav?.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Heiti SC", size: 20)!, NSForegroundColorAttributeName: UIColor(red: (36/255.0), green: (17/255.0), blue: (0/255.0), alpha: 1.0)]
        nav?.tintColor = UIColor(red: (36/255.0), green: (17/255.0), blue: (0/255.0), alpha: 1.0)
        btnSave.layer.cornerRadius = 5
        
        txtRound1!.text = self.round1
        txtRound2!.text = self.round2
        txtRound3!.text = self.round3
    }
    @IBAction func saveCustNoti() {
        print("Save Customer Notification")
        var numberList : [Int] = []
        if(self.txtRound1!.text != "" && Int(self.txtRound1!.text!)! != 0){
            numberList.append(Int(self.txtRound1!.text!)!)
        }
        if(self.txtRound2!.text != "" && Int(self.txtRound2!.text!)! != 0){
            numberList.append(Int(self.txtRound2!.text!)!)
        }
        if(self.txtRound3!.text != "" && Int(self.txtRound3!.text!)! != 0){
            numberList.append(Int(self.txtRound3!.text!)!)
        }
        print("Input \(numberList)")
        print("Output \(bubbleSort(numberList))")
        numberList = bubbleSort(numberList)
        for (var i = numberList.count-1 ; i < 2 ; i++) {
            numberList.append(0)
        }
        rest.res_noti_1 = numberList[0]
        rest.res_noti_2 = numberList[1]
        rest.res_noti_3 = numberList[2]
        RestaurantController().updateItem(rest)
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func bubbleSort(var numberList : [Int]) -> [Int]{
        var x, y, z, passes, key : Int
        //track collection iterations
        for x in 0..<numberList.count {
            passes = (numberList.count - 1) - x;
            //use shorthand "half-open" range operator
            for y in 0..<passes {
                key = numberList[y]
                //compare and rank values
                if (key < numberList[y + 1])
                {
                    z = numberList[y + 1]
                    numberList[y + 1] = key
                    numberList[y] = z
                }
            } //end for
        } //end for
        return numberList
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
