//
//  UserStaffController.swift
//  SmartQRes
//
//  Created by Kamnung Pitukkorn on 1/27/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import Foundation

class UserStaffController {
    var queryPredicate:NSPredicate!
    var itemList: [UserStaff] = []
    var authen = false
    var filteredListItems = [UserStaff]()
    let instance = SingletonClass.shared
    var datastore: CDTStore!
    var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    init() {
        self.datastore = instance.connectionSmartQDB()
        self.datastore.mapper.setDataType("UserStaff", forClassName: NSStringFromClass(UserStaff.classForCoder()))
        
        self.datastore.createIndexWithName("ItemNameIndex", fields: ["uss_username","uss_password"], completionHandler: { (error:NSError!) -> Void in
        })
    }
    
    func reloadLocalTableData() {
        self.filteredListItems = self.itemList
        
        if (self.filteredListItems.count==0){
            var username:NSString = "unknow"
            var usertype:NSNumber = 0
            var branchid:NSNumber = 0
            var resid:NSNumber = 0
            prefs.setObject(username, forKey: "USERNAME")
            prefs.setInteger(1, forKey: "ISLOGGEDIN")
            prefs.setObject(usertype, forKey: "USERTYPE")
            prefs.setObject(branchid, forKey: "BRANCHID")
            prefs.setObject(resid, forKey: "RESID")
            prefs.setBool(false, forKey: "AUTHEN")
            prefs.synchronize()
        }
        else{
            let item = self.filteredListItems[0] as UserStaff
            self.authen = true
            var username:NSString = item.uss_username
            var usertype:NSNumber = item.uss_type
            var branchid:NSNumber = item.uss_bra_id
            var resid:NSNumber = item.uss_res_id
            prefs.setObject(username, forKey: "USERNAME")
            prefs.setInteger(1, forKey: "ISLOGGEDIN")
            prefs.setObject(usertype, forKey: "USERTYPE")
            prefs.setObject(branchid, forKey: "BRANCHID")
            prefs.setObject(resid, forKey: "RESID")
            prefs.setBool(true, forKey: "AUTHEN")
            prefs.synchronize()
        }
        
    }
    
    func getAuthenStaff(username: String,password: String, uiView : LogInViewController) -> Void{
        //self.instance.pullReplicator.delegate = uiView
       // NSThread.sleepForTimeInterval(0.5)
       // self.instance.pullItems()
        
        var query:CDTQuery
        self.queryPredicate = NSPredicate(format: "(uss_password = %@ AND uss_username = %@)",password,username)
        query = CDTCloudantQuery(dataType: "UserStaff", withPredicate: self.queryPredicate)
        
        self.datastore.performQuery(query, completionHandler: { (results, error) -> Void in
            if((error) != nil) {
                NSLog("listItems failed with error \(error)")
                print(error)
            }
            else{
                self.itemList = results as! [UserStaff]
                for i in 0..<self.itemList.count{
                    let item = self.itemList[i] as UserStaff//self.filteredListItems[1] as UserStaff
                    print("<---------------UserName : \(item.uss_username)------------------>")
                    print("<---------------Password : \(item.uss_password)------------------>")
                    print("<---------------Type : \(item.uss_type)------------------>")
                    
                }
                self.reloadLocalTableData()
                
            }
        })
    }
    
    func getUserStaffListByBraId(braId : NSNumber, uiView : ManageBranchAdminTableViewController){
        self.instance.pullItems()
        var query:CDTQuery
        self.datastore.createIndexWithName("userStaffIndex", fields: ["uss_bra_id", "uss_type"], completionHandler: { (error:NSError!) -> Void in
        })
        self.queryPredicate = NSPredicate(format: "(uss_bra_id = %@ AND uss_type = %@)",braId, Constants.AdminType.Branch)
        query = CDTCloudantQuery(dataType: "UserStaff", withPredicate: self.queryPredicate)
        
        self.datastore.performQuery(query, completionHandler: { (results, error) -> Void in
            if((error) != nil) {
                NSLog("listItems failed with error \(error)")
                print(error)
            }
            else{
                self.itemList = results as! [UserStaff]
                var os = NSMutableOrderedSet()
                os.addObjectsFromArray(self.itemList)
                let sd = NSSortDescriptor(key: "uss_username", ascending: true)
                os.sortUsingDescriptors([sd])
                self.itemList = os.array as! [UserStaff]
                uiView.adminList = self.itemList
                uiView.tableView.reloadData()
                
            }
        })
        
    }
    
    func getUserStaffInfo(ussId : NSNumber, uiView : ViewBranchAdminViewController){
        self.instance.pullItems()
        var query:CDTQuery
        self.datastore.createIndexWithName("viewUserStaffIndex", fields: ["uss_id"], completionHandler: { (error:NSError!) -> Void in
        })
        self.queryPredicate = NSPredicate(format: "(uss_id = %@)",ussId)
        query = CDTCloudantQuery(dataType: "UserStaff", withPredicate: self.queryPredicate)
        
        self.datastore.performQuery(query, completionHandler: { (results, error) -> Void in
            if((error) != nil) {
                NSLog("listItems failed with error \(error)")
                print(error)
            }
            else{
                self.itemList = results as! [UserStaff]
                if(self.itemList.count != 0){
                    let userStaff = self.itemList[0] as UserStaff
                    uiView.labelUsername.text! = userStaff.uss_username as String
                }
            
            }
        })
        
    }
    
    func checkDuplicateUserName(item: UserStaff, uiView : EditBranchAdminViewController) {
        // Check duplicate
        self.instance.pullItems()
        var query : CDTQuery
        self.datastore.createIndexWithName("UserDuplicateIndex", fields: ["uss_username"], completionHandler: { (error:NSError!) -> Void in
        })
        self.queryPredicate = NSPredicate(format: "(uss_username = %@)", item.uss_username)
        query = CDTCloudantQuery(dataType: "UserStaff", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
            }
            else{
                self.itemList = results as! [UserStaff]
                // if branch name have not already existed, the application allows to save info
                if(self.itemList.count == 0 || (self.itemList.count == 1 && self.itemList[0].uss_id == item.uss_id)){
                    uiView.isDuplicate = false
                }else{
                    uiView.isDuplicate = true
                }
            }
            
        })
    }
    
    func checkDuplicateUserName(item: UserStaff, uiView : AddBranchAdminViewController) {
        // Check duplicate
        self.instance.pullItems()
        var query : CDTQuery
        self.datastore.createIndexWithName("UserDuplicateIndex", fields: ["uss_username"], completionHandler: { (error:NSError!) -> Void in
        })
        self.queryPredicate = NSPredicate(format: "(uss_username = %@)", item.uss_username)
        query = CDTCloudantQuery(dataType: "UserStaff", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
            }
            else{
                self.itemList = results as! [UserStaff]
                // if branch name have not already existed, the application allows to save info
                if(self.itemList.count == 0 || (self.itemList.count == 1 && self.itemList[0].uss_id == item.uss_id)){
                    uiView.isDuplicate = false
                }else{
                    uiView.isDuplicate = true
                }
            }
            
        })
    }
    
    func createUserStaff(userStaff: UserStaff){
        self.instance.pullItems()
        
        var query : CDTQuery
        query = CDTCloudantQuery(dataType: "UserStaff")
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print("ERROR --> \(error) ")
            }
            else{
                self.itemList = results as! [UserStaff]
                if(self.itemList.count != 0){
                    
                    var os = NSMutableOrderedSet()
                    os.addObjectsFromArray(self.itemList)
                    let sd = NSSortDescriptor(key: "uss_id", ascending: true)
                    os.sortUsingDescriptors([sd])
                    self.itemList = os.array as! [UserStaff]
                    
                    var temp : UserStaff = UserStaff()
                    temp = self.itemList[self.itemList.count-1]
                    userStaff.uss_id = temp.uss_id.integerValue + 1
                    print("LAST uss_id : \(userStaff.uss_id)")
                    self.datastore.save(userStaff, completionHandler: {(object, error) -> Void in
                        if(error != nil){
                            print("Error on create User Staff: \(error)")
                        
                        }else{
                            print("Create User Staff Successfully.")
                            self.instance.pushItems()
                        }
                    })
                }
            }
        })
        
        

    }
    
    func updateUserStaff(userStaff: UserStaff) {
        self.datastore.save(userStaff, completionHandler: { (object, error) -> Void in
            if(error != nil){
                print("update user staff failed with error \(error)")
            } else {
                print("Update User Staff complete")
                self.instance.pushItems()
            }
        })
    }
    
    func deleteUserStaff(userStaff: UserStaff){
        self.datastore.delete(userStaff, completionHandler: { (deletedObjectId:String!, deletedRevisionId:String!, error:NSError!) -> Void in
            if(error != nil){
                print("delete Item failed with error \(error)")
            } else {
                print("Delete User Staff Successfully")
                self.instance.pushItems()
            }
        })
    }
}