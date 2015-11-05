//
//  CurrentRunningNoController.swift
//  SmartQ
//
//  Created by Worayut Traiworadecha on 2/6/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import Foundation

class CurrentRunningNoController{
    
    var currentRunningNo : CurrentRunningNo = CurrentRunningNo()
    var currentRunningNoList : [CurrentRunningNo] = []
    var queryPredicate : NSPredicate!
    var instance = SingletonClass.shared
    let datastore: CDTStore!
    var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    init(){
        
        self.datastore = instance.connectionSmartQDB()
        self.datastore.mapper.setDataType("CurrentRunningNo", forClassName: NSStringFromClass(CurrentRunningNo.classForCoder()))
        
        self.datastore.createIndexWithName("CurrentRunningNoIndex", fields: ["cur_bra_id"], completionHandler: { (error:NSError!) -> Void in
        })
        
        
    }
    
    
    func getCurrentRunningNoByBraId(cur_bra_id : NSNumber, uiView: BookingQViewController) -> Void {
        
        print("CURRENTRUNNINGNO CONTROLLER [getCurrentRunningNoByBraId] ")
        self.instance.pullItems()
        
        var query : CDTQuery
        self.queryPredicate = NSPredicate(format: "(cur_bra_id = %@)", cur_bra_id)
        query = CDTCloudantQuery(dataType: "CurrentRunningNo", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print("Error on query CurrentRunningNo by braId = \(cur_bra_id)")
                
            }else{
                self.currentRunningNoList = results as! [CurrentRunningNo]
                if(self.currentRunningNoList.count != 1){
                    print("Found more than one CurrentRunningNo \(self.currentRunningNoList.count) for bra_id = \(cur_bra_id)")
                }else{
                    self.currentRunningNo = self.currentRunningNoList[0]
                    print("Current Running for bra_id \(cur_bra_id) -> [A: \(self.currentRunningNo.cur_ty_a)] [B: \(self.currentRunningNo.cur_ty_b)] [C: \(self.currentRunningNo.cur_ty_c)] [D: \(self.currentRunningNo.cur_ty_d)]")
                    
                    uiView.currentRunningNo = self.currentRunningNo
                    
                }
            }
            
        })
        
    }
    
    
    func getCurrentRunningNoByBraId(cur_bra_id : NSNumber, tb_type: NSString) -> Void {
        
        print("CURRENTRUNNINGNO CONTROLLER [getCurrentRunningNoByBraId] ")
        self.instance.pullItems()
        
        var query : CDTQuery
        self.queryPredicate = NSPredicate(format: "(cur_bra_id = %@)", cur_bra_id)
        query = CDTCloudantQuery(dataType: "CurrentRunningNo", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print("Error on query CurrentRunningNo by braId = \(cur_bra_id)")
                
            }else{
                self.currentRunningNoList = results as! [CurrentRunningNo]
                if(self.currentRunningNoList.count != 1){
                    print("Found more than one CurrentRunningNo \(self.currentRunningNoList.count) for bra_id = \(cur_bra_id)")
                }else{
                    self.currentRunningNo = self.currentRunningNoList[0]
                    print("Current Running for bra_id \(cur_bra_id) -> [A: \(self.currentRunningNo.cur_ty_a)] [B: \(self.currentRunningNo.cur_ty_b)] [C: \(self.currentRunningNo.cur_ty_c)] [D: \(self.currentRunningNo.cur_ty_d)]")
                    
                }
            }
            
        })
        
    }
    
    
    
    
    
    func updateCurrentRunningNo(currentRunningNo : CurrentRunningNo) -> Void {
        print("CURRENTRUNNINGNO CONTROLLER [updateCurrentRunningNo] ")
        datastore.save(currentRunningNo, completionHandler: { (object, error) -> Void in
            
            if(error != nil){
                //self.logger.logErrorWithMessages("createItem failed with error \(error.description)")
                print("Error on update currentRunningNo \(error)")
                
            } else {
                self.currentRunningNo = object as! CurrentRunningNo
                print("Update currentRunningNo Successfully")
                
            }
        })
        self.instance.pushItems()
        
    }
    
    func createItem(var item: CurrentRunningNo) {
        self.instance.pullItems()
        
        var query : CDTQuery
        query = CDTCloudantQuery(dataType: "CurrentRunningNo")
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print("ERROR --> \(error) ")
            }
            else{
                self.currentRunningNoList = results as! [CurrentRunningNo]
                if(self.currentRunningNoList.count >= 1){
                    var os = NSMutableOrderedSet()
                    os.addObjectsFromArray(self.currentRunningNoList)
                    let sd = NSSortDescriptor(key: "cur_id", ascending: true)
                    os.sortUsingDescriptors([sd])
                    self.currentRunningNoList = os.array as! [CurrentRunningNo]
                
                    var temp : CurrentRunningNo = CurrentRunningNo()
                    temp = self.currentRunningNoList[self.currentRunningNoList.count-1]
                    item.cur_id = temp.cur_id.integerValue + 1
                }else{
                    item.cur_id = 1
                }
                print("LAST cur_id : \(item.cur_id)")
                self.datastore.save(item, completionHandler: { (object, error) -> Void in
                    if(error != nil){
                        print("create Item failed with error \(error)")
                    } else {
                        print("Create Running Number Successfully")
                        self.instance.pushItems()
                    }
                })
                
            }
        })
        
    }
}