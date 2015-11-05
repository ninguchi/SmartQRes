//
//  DataController.swift
//  SmartQRes
//
//  Created by Kamnung Pitukkorn on 2/25/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import Foundation

class DataController{
    
    var store: CDTStore!
    var error:NSError?
    var remoteStore: CDTStore!
    var dataType:String = ""
    var branch = Branch()
    var branchList : [Branch] = []
    
    init() {
        do {
            self.store = try IMFDataManager.sharedInstance().localStore("smartqdb")
            IMFDataManager.sharedInstance().remoteStore("smartqdb", completionHandler: { (store:CDTStore!, error:NSError!) -> Void in
                self.remoteStore = store
            })
            IMFDataManager.sharedInstance().setCurrentUserPermissions(DB_ACCESS_GROUP_ADMINS, forStoreName: "smartqdb") { (success:Bool, error:NSError!) -> Void in
                // If successful, success is 'true' and error is 'nil'
            }
        
        }catch _ {
            print("cannot connect DB")
        }

    }
    
    func getDataList(){
        
        // dataType can for a class can be looked up using the CDTDataObjectMapper
        self.dataType = self.store.mapper.dataTypeForClassName(NSStringFromClass(Branch.classForCoder()))
        var queryPredicate:NSPredicate = NSPredicate(format: "(bra_id = 1)")
        
        // Create a query with an NSPredicate AND @datatype=dataType
        var query:CDTCloudantQuery = CDTCloudantQuery(dataType: self.dataType, withPredicate: queryPredicate)
        self.store.performQuery(query, completionHandler: { (results:[AnyObject]!, error:NSError!) -> Void in
            //results is an array of Item objects that are returned by the query
            self.branchList = results as! [Branch]
            for i in 0..<self.branchList.count{
                self.branch = self.branchList[i] as Branch
            }
        })
    }
    
}