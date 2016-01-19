//
//  BranchController.swift
//  SmartQ
//
//  Created by Worayut Traiworadecha on 2/5/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import Foundation
class BranchController{
    
    var replicatorFactory: CDTReplicatorFactory!
    var pushReplication: CDTPushReplication!
    var queryPredicate:NSPredicate!
    var branch = Branch()
    var branchList : [Branch] = []
    var filteredListBranch = [Branch]()
    let instance = SingletonClass.shared
    var datastore: CDTStore!
    let branchStatusList = ["Service", "Renovate","Stop Service", "Out Of Service"]
    
    init() {
        self.datastore = instance.connectionSmartQDB()
        self.datastore.mapper.setDataType("Branch", forClassName: NSStringFromClass(Branch.classForCoder()))
        self.datastore.createIndexWithName("BranchIndex", fields: ["bra_id", "bra_res_id"], completionHandler: { (error:NSError!) -> Void in
        })
    }
    
    func getBranchListByResId(res_id : NSNumber, uiView : ManageBranchTableViewController)  {
        var query : CDTQuery
        self.queryPredicate = NSPredicate(format: "(bra_res_id = %@)", res_id)
        
        query = CDTCloudantQuery(dataType: "Branch", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
            }
            else{
                self.branchList = results as! [Branch]
                var os = NSMutableOrderedSet()
                os.addObjectsFromArray(self.branchList)
                let sd = NSSortDescriptor(key: "bra_name", ascending: true)
                os.sortUsingDescriptors([sd])
                self.branchList = os.array as! [Branch]
                uiView.branchList = self.branchList
                uiView.tableView.reloadData()
            }
        })
        
    }
    
    func reloadLocalTableData() {
        self.filteredListBranch = self.branchList
        
        let alert = UIAlertView()
        alert.title = "XXXX"
        alert.message = "This is "+self.filteredListBranch.count.description
        alert.addButtonWithTitle("Ok")
        alert.show()
    }
    
    func getBranchById(bra_id : NSNumber, uiView : ViewGeneralInfoViewController) -> Void {
        var query : CDTQuery
        self.queryPredicate = NSPredicate(format: "(bra_id = %@)", bra_id)
        query = CDTCloudantQuery(dataType: "Branch", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
            }
            else{
                //self.instance.pullItems()
                self.branchList = results as! [Branch]
                for i in 0..<self.branchList.count{
                    self.branch = self.branchList[i] as Branch
                    
                    print("<---------------BranchName : \(self.branch.bra_name)------------------>")
                    uiView.labelName.text = self.branch.bra_name as String
                    uiView.labelBranchLocation.text = self.branch.bra_location as String
                    uiView.labelBranchTime.text = self.branch.bra_service_time as String
                    if (self.branch.bra_status as Int > 0){
                        uiView.labelBranchStatus.text = self.branchStatusList[self.branch.bra_status as Int-1]
                    }
                    uiView.labelBranchContactNo.text = self.branch.bra_contact_no as String
                    uiView.editBranch = self.branch
                    ShoppingMallController().getShoppingMallById(self.branch.bra_sho_id, uiView: uiView)
                    self.instance.branchController = self
                    
                }
            }
            
        })
        
    }
    
    func getBranchById(bra_id : NSNumber, uiView : ViewTableTypeSettingViewController) -> Void {
        var query : CDTQuery
        self.queryPredicate = NSPredicate(format: "(bra_id = %@)", bra_id)
        query = CDTCloudantQuery(dataType: "Branch", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
            }
            else{
                //self.instance.pullItems()
                self.branchList = results as! [Branch]
                for i in 0..<self.branchList.count{
                    self.branch = self.branchList[i] as Branch
                    
                    print("<---------------BranchName : \(self.branch.bra_name)------------------>")
                    uiView.labelAMax.text = self.branch.bra_ty_a_max.stringValue
                    uiView.labelBMax.text = self.branch.bra_ty_b_max.stringValue
                    uiView.labelCMax.text = self.branch.bra_ty_c_max.stringValue
                    uiView.labelDMax.text = self.branch.bra_ty_d_max.stringValue
                    uiView.labelATurnOver.text = self.branch.bra_ty_a_turnover.stringValue
                    uiView.labelBTurnOver.text = self.branch.bra_ty_b_turnover.stringValue
                    uiView.labelCTurnOver.text = self.branch.bra_ty_c_turnover.stringValue
                    uiView.labelDTurnOver.text = self.branch.bra_ty_d_turnover.stringValue
                    uiView.editBranch = self.branch
                    self.instance.branchController = self
                    
                    
                }
            }
            
        })
        
    }
    
    func getBranchById(bra_id : NSNumber, uiView : ViewCustNotiSettingViewController) -> Void {
        var query : CDTQuery
        self.queryPredicate = NSPredicate(format: "(bra_id = %@)", bra_id)
        query = CDTCloudantQuery(dataType: "Branch", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
            }
            else{
                //self.instance.pullItems()
                self.branchList = results as! [Branch]
                for i in 0..<self.branchList.count{
                    self.branch = self.branchList[i] as Branch
                    
                    print("<---------------BranchName : \(self.branch.bra_name)------------------>")
                    uiView.labelRound1.text = self.branch.bra_noti_1.stringValue
                    uiView.labelRound2.text = self.branch.bra_noti_2.stringValue
                    uiView.labelRound3.text = self.branch.bra_noti_3.stringValue
                    uiView.editBranch = self.branch
                    self.instance.branchController = self
                    
                }
            }
            
        })
        
    }
    
    func getBranchById(bra_id : NSNumber, uiView : ManageQViewController) -> Void {
        
        self.instance.pullItems()
        var query : CDTQuery
        self.queryPredicate = NSPredicate(format: "(bra_id = %@)", bra_id)
        query = CDTCloudantQuery(dataType: "Branch", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
            }
            else{
                
                self.branchList = results as! [Branch]
                if(self.branchList.count != 0){
                    self.branch = self.branchList[0] as Branch
                    uiView.branch = self.branch
                    print("<---------------BranchName : \(self.branch.bra_name)------------------>")
                    if(self.branch.bra_ty_a_max != 0){
                        uiView.labelTypeA.text = "(\(self.branch.bra_ty_a_min) - \(self.branch.bra_ty_a_max))"
                    }
                    else {
                        uiView.labelA.hidden = true
                        uiView.labelTypeA.hidden = true
                        uiView.labelWaitingA.hidden = true
                        uiView.labelNoShowA.hidden = true
                        uiView.tableViewTypeANoShow.hidden = true
                        uiView.tableViewTypeAWaiting.hidden = true
                        uiView.btnCallNextQA.hidden = true
                        uiView.btnCurrentTypeA.hidden = true
                    }
                    if(self.branch.bra_ty_b_max != 0){
                        uiView.labelTypeB.text = "(\(self.branch.bra_ty_b_min) - \(self.branch.bra_ty_b_max))"
                    }
                    else {
                        uiView.labelB.hidden = true
                        uiView.labelTypeB.hidden = true
                        uiView.labelWaitingB.hidden = true
                        uiView.labelNoShowB.hidden = true
                        uiView.tableViewTypeBNoShow.hidden = true
                        uiView.tableViewTypeBWaiting.hidden = true
                        uiView.btnCallNextQB.hidden = true
                        uiView.btnCurrentTypeB.hidden = true
                    }
                    if(self.branch.bra_ty_c_max != 0){
                        uiView.labelTypeC.text = "(\(self.branch.bra_ty_c_min) - \(self.branch.bra_ty_c_max))"
                    }
                    else {
                        uiView.labelC.hidden = true
                        uiView.labelTypeC.hidden = true
                        uiView.labelWaitingC.hidden = true
                        uiView.labelNoShowC.hidden = true
                        uiView.tableViewTypeCNoShow.hidden = true
                        uiView.tableViewTypeCWaiting.hidden = true
                        uiView.btnCallNextQC.hidden = true
                        uiView.btnCurrentTypeC.hidden = true
                    }
                    if(self.branch.bra_ty_d_max != 0){
                        uiView.labelTypeD.text = "(\(self.branch.bra_ty_d_min) - \(self.branch.bra_ty_d_max))"
                    }
                    else {
                        uiView.labelD.hidden = true
                        uiView.labelTypeD.hidden = true
                        uiView.labelWaitingD.hidden = true
                        uiView.labelNoShowD.hidden = true
                        uiView.tableViewTypeDNoShow.hidden = true
                        uiView.tableViewTypeDWaiting.hidden = true
                        uiView.btnCallNextQD.hidden = true
                        uiView.btnCurrentTypeD.hidden = true
                    }
                }
            }
            
        })
        
    }
    
    func getBranchById(bra_id : NSNumber, uiView: BookingQViewController) -> Void {
        print("BRANCH CONTROLLER [getBranchListById] ")
        
        self.instance.pullItems()
        
        var query : CDTQuery
        self.queryPredicate = NSPredicate(format: "(bra_id = %@)", bra_id)
        query = CDTCloudantQuery(dataType: "Branch", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
            }
            else{
                self.branchList = results as! [Branch]
                if(self.branchList.count != 1){
                    print("Found more than one branch [id = \(bra_id)]")
                    
                }else{
                    self.branch = self.branchList[0]
                    uiView.branchObj = self.branch
                }
            }
            
        })
        
    }
    
    func getBranchNameById(bra_id : NSNumber, uiView : MainDetailBranchViewController) -> Void {
        var query : CDTQuery
        self.queryPredicate = NSPredicate(format: "(bra_id = %@)", bra_id)
        query = CDTCloudantQuery(dataType: "Branch", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
            }
            else{
                //self.instance.pullItems()
                self.branchList = results as! [Branch]
                for i in 0..<self.branchList.count{
                    self.branch = self.branchList[i] as Branch
                    
                    print("<---------------BranchName : \(self.branch.bra_name)------------------>")
                    uiView.labelBranchName.text = self.branch.bra_name as String
                    //
                    uiView.imageRestaurant.image = UIImage(named: "\(self.branch.bra_res_name).png")
                    self.instance.branchController = self
                    
                }
            }
            
        })
        
    }
    
    func getBranchById(bra_id : NSNumber, uiView : ViewBranchViewController) -> Void {
        var query : CDTQuery
        //self.instance.pullItems()
        self.queryPredicate = NSPredicate(format: "(bra_id = %@)", bra_id)
        query = CDTCloudantQuery(dataType: "Branch", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
            }
            else{
                self.branchList = results as! [Branch]
                for i in 0..<self.branchList.count{
                    self.branch = self.branchList[i] as Branch
                    
                    print("<---------------BranchName : \(self.branch.bra_name)------------------>")
                    uiView.labelBranchName.text = self.branch.bra_name as String
                    uiView.labelBranchLocation.text = self.branch.bra_location as String
                    uiView.labelBranchTime.text = self.branch.bra_service_time as String
                    if (self.branch.bra_status as Int > 0){
                        uiView.labelBranchStatus.text = self.branchStatusList[self.branch.bra_status as Int-1]
                    }
                    uiView.labelBranchContactNo.text = self.branch.bra_contact_no as String
                    uiView.branch = self.branch
                    ShoppingMallController().getShoppingMallById(self.branch.bra_sho_id, uiView: uiView)
                    self.instance.branchController = self
                    
                }
            }
            
        })
        
    }
    
    func getBranchById(bra_id : NSNumber, uiView : MasterTableViewController) -> Void {
        var query : CDTQuery
        self.queryPredicate = NSPredicate(format: "(bra_id = %@)", bra_id)
        query = CDTCloudantQuery(dataType: "Branch", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
            }
            else{
                //self.instance.pullItems()
                self.branchList = results as! [Branch]
                if(self.branchList.count == 1){/*
                    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
                    imageView.contentMode = .ScaleAspectFit
                    let image = UIImage(named: self.branchList[0].bra_res_name)
                    imageView.image = image
                    uiView.navigationItem.titleView?.addSubview(imageView)*/
                    uiView.navigationItem.title = self.branchList[0].bra_res_name as String + " [\(self.branchList[0].bra_name)]"
                }
            }
            
        })
        
    }
    
    func getBranchForDelete(bra_id : NSNumber, uiView : MainDetailBranchViewController) -> Void {
        var query : CDTQuery
        self.queryPredicate = NSPredicate(format: "(bra_id = %@)", bra_id)
        query = CDTCloudantQuery(dataType: "Branch", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
            }
            else{
                self.instance.pullItems()
                self.branchList = results as! [Branch]
                for i in 0..<self.branchList.count{
                    self.branch = self.branchList[i] as Branch
                    
                    print("<---------------BranchName : \(self.branch.bra_name)------------------>")
                    uiView.labelBranchName.text = self.branch.bra_name as String
                    self.deleteItem(self.branch)
                    self.instance.branchController = self
                    
                }
            }
            
        })
        
    }
    
    func updateItem(item: Branch) {
        self.datastore.save(item, completionHandler: { (object, error) -> Void in
            if(error != nil){
                print("updateItem failed with error \(error)")
            } else {
                self.instance.pushItems()
            }
        })
    }
    
    func checkDuplicateBranchName(item: Branch, uiView : EditGeneralInfoViewController) {
        // Check duplicate
        self.instance.pullItems()
        var query : CDTQuery
        self.datastore.createIndexWithName("BranchDuplicateIndex", fields: ["bra_name", "bra_res_id"], completionHandler: { (error:NSError!) -> Void in
        })
        self.queryPredicate = NSPredicate(format: "(bra_name = %@ and bra_res_id = %@)", item.bra_name, item.bra_res_id)
        query = CDTCloudantQuery(dataType: "Branch", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
            }
            else{
                self.branchList = results as! [Branch]
                // if branch name have not already existed, the application allows to save info
                if(self.branchList.count == 0 || (self.branchList.count == 1 && self.branchList[0].bra_id == item.bra_id)){
                    uiView.isDuplicate = false
                }else{
                    uiView.isDuplicate = true
                }
            }
            
        })
    }
    
    func checkDuplicateBranchName(item: Branch, uiView : EditBranchViewController) {
        // Check duplicate
        self.instance.pullItems()
        var query : CDTQuery
        self.datastore.createIndexWithName("BranchDuplicateIndex", fields: ["bra_name", "bra_res_id"], completionHandler: { (error:NSError!) -> Void in
        })
        self.queryPredicate = NSPredicate(format: "(bra_name = %@ and bra_res_id = %@)", item.bra_name, item.bra_res_id)
        query = CDTCloudantQuery(dataType: "Branch", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
            }
            else{
                self.branchList = results as! [Branch]
                // if branch name have not already existed, the application allows to save info
                if(self.branchList.count == 0 || (self.branchList.count == 1 && self.branchList[0].bra_id == item.bra_id)){
                    uiView.isDuplicate = false
                }else{
                    uiView.isDuplicate = true
                }
            }
            
        })
    }

    
    func createItem(var item: Branch) {
        self.instance.pullItems()
        
        var query : CDTQuery
        query = CDTCloudantQuery(dataType: "Branch")
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print("ERROR --> \(error) ")
            }
            else{
                self.branchList = results as! [Branch]
                
                var os = NSMutableOrderedSet()
                os.addObjectsFromArray(self.branchList)
                let sd = NSSortDescriptor(key: "bra_id", ascending: true)
                os.sortUsingDescriptors([sd])
                self.branchList = os.array as! [Branch]
                
                var temp : Branch = Branch()
                temp = self.branchList[self.branchList.count-1]
                item.bra_id = temp.bra_id.integerValue + 1
                print("LAST bra_id : \(item.bra_id)")
                self.datastore.save(item, completionHandler: { (object, error) -> Void in
                    if(error != nil){
                        print("create Item failed with error \(error)")
                    } else {
                        print("Create Branch Successfully")
                        self.instance.pushItems()
                        let runningNo = CurrentRunningNo()
                        runningNo.cur_bra_id = (object as! Branch).bra_id
                        CurrentRunningNoController().createItem(runningNo)
                    }
                })

            }
        })
        
    }
    
    func deleteItem(item: Branch) {
        
        self.datastore.delete(item, completionHandler: { (deletedObjectId:String!, deletedRevisionId:String!, error:NSError!) -> Void in
            if(error != nil){
                print("delete Item failed with error \(error)")
            } else {
                print("Delete Branch Successfully")
                self.instance.pushItems()
            }
        })
    }

    func getBranchList () -> Void {
        
        var query : CDTQuery
        query = CDTCloudantQuery(dataType: "Branch")
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
            }
            else{
                self.branchList = results as! [Branch]
                
                var os = NSMutableOrderedSet()
                os.addObjectsFromArray(self.branchList)
                let sd = NSSortDescriptor(key: "bra_res_id", ascending: true)
                os.sortUsingDescriptors([sd])
                self.branchList = os.array as! [Branch]
                for item in self.branchList {
                    print("res id \(item.bra_res_id) bra_name \(item.bra_name) bra_id \(item.bra_id) " )
                }
            }
        })
    }
    func updateBranchById(bra_id : NSNumber) -> Void {
        var query : CDTQuery
        //self.instance.pullItems()
        self.queryPredicate = NSPredicate(format: "(bra_id = %@)", bra_id)
        query = CDTCloudantQuery(dataType: "Branch", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
            }
            else{
                self.branchList = results as! [Branch]
                for i in 0..<self.branchList.count{
                    self.branch = self.branchList[i] as Branch
                    self.branch.bra_name = "Siam Center"
                    self.updateItem(self.branch)
                    
                }
            }
            
        })
        
    }
}