//
//  EditTableTypeSettingViewController.swift
//  SmartQRes
//
//  Created by ninguchi on 2/9/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import UIKit

class EditTableTypeSettingViewController: UIViewController {

    @IBOutlet weak var txtAMax: UITextField!
    @IBOutlet weak var txtBMax: UITextField!
    @IBOutlet weak var txtCMax: UITextField!
    @IBOutlet weak var txtDMax: UITextField!
    @IBOutlet weak var txtATurnOver: UITextField!
    @IBOutlet weak var txtBTurnOver: UITextField!
    @IBOutlet weak var txtCTurnOver: UITextField!
    @IBOutlet weak var txtDTurnOver: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    
    var AMax:String = ""
    var BMax:String = ""
    var CMax:String = ""
    var DMax:String = ""
    var ATurnOver:String = ""
    var BTurnOver:String = ""
    var CTurnOver:String = ""
    var DTurnOver:String = ""
    
    var editBranch = Branch()
    let instance = SingletonClass.shared
    
    //var branchId:NSNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Main Detail View Controller")
        btnSave.layer.cornerRadius = 5
        txtAMax!.text = AMax
        txtBMax!.text = BMax
        txtCMax!.text = CMax
        txtDMax!.text = DMax
        txtATurnOver!.text = ATurnOver
        txtBTurnOver!.text = BTurnOver
        txtCTurnOver!.text = CTurnOver
        txtDTurnOver!.text = DTurnOver
    }

    @IBAction func saveTableTypeSetting() {
        //editBranch = self.instance.branchController.branch
        var A : [Int] = []
        var B : [Int] = []
        var C : [Int] = []
        var D : [Int] = []
        var arrayAll : [[Int]] = []
        if(txtAMax!.text != "" && Int(txtAMax!.text!)! != 0){
            A.append(Int(txtAMax!.text!)!)
            A.append(Int(txtATurnOver!.text!)!)
            arrayAll.append(A)
        }
        if(txtBMax!.text != "" && Int(txtBMax!.text!)! != 0){
            B.append(Int(txtBMax!.text!)!)
            B.append(Int(txtBTurnOver!.text!)!)
            arrayAll.append(B)
        }
        if(txtCMax!.text != "" && Int(txtCMax!.text!)! != 0){
            C.append(Int(txtCMax!.text!)!)
            C.append(Int(txtCTurnOver!.text!)!)
            arrayAll.append(C)
        }
        if(txtDMax!.text != "" && Int(txtDMax!.text!)! != 0){
            D.append(Int(txtDMax!.text!)!)
            D.append(Int(txtDTurnOver!.text!)!)
            arrayAll.append(D)
        }
        print("Input : \(A) \(B) \(C) \(D)")
        
        print("Input : \(arrayAll)")
        print("Output : \(bubbleSort(arrayAll))")
        var array : [[Int]]=bubbleSort(arrayAll)
        let zeroArray : [Int] = [0,0]
        for (var i = array.count-1 ; i < 3 ; i++) {
            array.append(zeroArray)
        }
        for i in 0..<array.count{
            if(i == 0){
                editBranch.bra_ty_a_max = array[0][0]
                editBranch.bra_ty_a_min = 1
                editBranch.bra_ty_a_turnover = array[0][1]
                print("A \(array[0][0])")
                print("\(array[0][1])")
            }
            if(i == 1){
                editBranch.bra_ty_b_max = array[1][0]
                editBranch.bra_ty_b_min = array[0][0]+1
                editBranch.bra_ty_b_turnover = array[1][1]
                print("B \(array[1][0])")
                print("\(array[1][1])")
            }
            if(i == 2){
                editBranch.bra_ty_c_max = array[2][0]
                editBranch.bra_ty_c_min = array[1][0]+1
                editBranch.bra_ty_c_turnover = array[2][1]
                print("C \(array[2][0])")
                print("\(array[2][1])")
            }
            if(i == 3){
                editBranch.bra_ty_d_max = array[3][0]
                editBranch.bra_ty_d_min = array[2][0]+1
                editBranch.bra_ty_d_turnover = array[3][1]
                print("D \(array[3][0])")
                print("\(array[3][1])")
            }
        }
        BranchController().updateItem(editBranch)
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertionSort(var numberList : [[Int]]) -> [[Int]]{
        var x, y, key : Int
        var array : [[Int]] = []
        let count = numberList.count - 1
        for (x = 0; x < count ; x++) {
            //obtain a key to be evaluated 
            print("x \(x)")
            key = numberList[x][0]
            
            //iterate backwards through the sorted portion
            for (y = x; y > -1; y--) {
                if (key < numberList[y][0])
                { //remove item from original position
                    print("(\(x),\(y))")
                    numberList.removeAtIndex(y + 1)
                    //insert the number at the key position
                    numberList.insert(numberList[x], atIndex: y)
                }
            } //end for
        }
        return numberList
    //end for 
    }
    
    func bubbleSort(var numberList : [[Int]]) -> [[Int]] {
        var x, y, passes : Int
        var z  : [Int]
        var key : [Int]
        for x in 0..<numberList.count{
            passes = (numberList.count - 1) - x;
            //use shorthand "half-open" range operator 
            for y in 0..<passes
            {
                key = numberList[y]
                //compare and rank values 
                if (key[0] > numberList[y + 1][0])
                {
                    z = numberList[y + 1]
                    numberList[y + 1] = key
                    numberList[y] = z
                }
            } //end for 
        } //end for
        return numberList
    }
    //end function
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
