//
//  UserStaffController.swift
//  SmartQRes
//
//  Created by Kamnung Pitukkorn on 1/27/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import Foundation

class CustomerController {
    var replicatorFactory: CDTReplicatorFactory!
    var pushReplication: CDTPushReplication!
    var queryPredicate:NSPredicate!
    var customer = Customer()
    var customerList : [Customer] = []
    let instance = SingletonClass.shared
    var datastore: CDTStore!
    
    init() {
        self.datastore = instance.connectionSmartQDB()
        self.datastore.mapper.setDataType("Customer", forClassName: NSStringFromClass(Customer.classForCoder()))
        self.datastore.createIndexWithName("CustomerIndex", fields: ["cus_id"], completionHandler: { (error:NSError!) -> Void in
        })
    }
    
    
    func checkDuplicateMethod(var datastore: CDTStore!, email: String){
        //Check duplicate user while create the new one
        
    }
    
    func sendNotiByType(tableType : NSString, uiView : ManageQViewController) {
        var notiQueueList : [Int] = []
        if(uiView.branch.bra_noti_1 != 0){
            notiQueueList.append(uiView.branch.bra_noti_1.integerValue)
        }
        if(uiView.branch.bra_noti_2 != 0){
            notiQueueList.append(uiView.branch.bra_noti_2.integerValue)
        }
        if(uiView.branch.bra_noti_3 != 0){
            notiQueueList.append(uiView.branch.bra_noti_3.integerValue)
        }
        
        print("========= Send Notification ========")
        var notiQueue :Int = 0
        var waitQueue :Queue = Queue()
        var waitQueueCount : Int = 0
        var waitQueueList : [Queue] = []
        if(tableType == Constants.TableType.A){
            waitQueueCount = uiView.listQueueTypeAWaiting.count
            waitQueueList = uiView.listQueueTypeAWaiting
        }else if(tableType == Constants.TableType.B){
            waitQueueCount = uiView.listQueueTypeBWaiting.count
            waitQueueList = uiView.listQueueTypeBWaiting
        }else if(tableType == Constants.TableType.C){
            waitQueueCount = uiView.listQueueTypeCWaiting.count
            waitQueueList = uiView.listQueueTypeCWaiting
        }else if(tableType == Constants.TableType.D){
            waitQueueCount = uiView.listQueueTypeDWaiting.count
            waitQueueList = uiView.listQueueTypeDWaiting
        }
        for i in 0..<notiQueueList.count {
            
            notiQueue = notiQueueList[i] // 5
            // A
            if(waitQueueCount >= notiQueue){
                waitQueue = waitQueueList[notiQueue-1]
                print("Queue No. : \(tableType)\(waitQueue.que_no.integerValue.format(Constants.DecimalFormat.Queue))")
                if(waitQueue.que_type == Constants.QueueType.Client){
                    print("Reserve by Client User")
                    self.sendNotiToCustomerById(waitQueue.que_cus_id)
                }else{
                    print("Reserved by Restaurant")
                }
                print("Waiting Queue : \(notiQueue)")
                print("-----------------------------------")
            }
            
        }
        print("====================================")
        
    }
    
    func sendNotiToCustomerById(cus_id : NSNumber) {
        var query : CDTQuery
        self.instance.pullItems()
        self.queryPredicate = NSPredicate(format: "(cus_id = %@)", cus_id)
        
        query = CDTCloudantQuery(dataType: "Customer", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
            }
            else{
                self.customerList = results as! [Customer]
                if(self.customerList.count != 0){
                    self.customer = self.customerList[0]
                    print("Name : \(self.customer.cus_firstname) \(self.customer.cus_lastname)")
                    print("Mobile No. : \(self.customer.cus_mobile_no)")
                }
            }
            
        })
    }
    
}