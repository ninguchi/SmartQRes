//
//  EditCustNotiSettingViewController.swift
//  SmartQRes
//
//  Created by ninguchi on 2/9/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import UIKit

class EditCustNotiSettingViewController: UIViewController {
    @IBOutlet weak var txtRound1: UITextField!
    @IBOutlet weak var txtRound2: UITextField!
    @IBOutlet weak var txtRound3: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    //Variable
    var round1:String = ""
    var round2:String = ""
    var round3:String = ""
    var editBranch = Branch()
    let instance = SingletonClass.shared
    
    var branchId:NSNumber=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Main Detail View Controller")
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let branchId:NSNumber = prefs.integerForKey("BRANCHID") as NSNumber
        self.branchId = branchId
        // Do any additional setup after loading the view.
        btnSave.layer.cornerRadius = 5
        txtRound1!.text = self.round1
        txtRound2!.text = self.round2
        txtRound3!.text = self.round3
    }

    @IBAction func saveCustNoti() {
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
        editBranch.bra_noti_1 = numberList[0]
        editBranch.bra_noti_2 = numberList[1]
        editBranch.bra_noti_3 = numberList[2]
        BranchController().updateItem(editBranch)
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
