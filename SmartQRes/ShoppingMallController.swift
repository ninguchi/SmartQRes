//
//  ShoppingMallController.swift
//  SmartQ
//
//  Created by Worayut Traiworadecha on 2/5/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import Foundation

class ShoppingMallController{
    
    var queryPredicate: NSPredicate!
    var shoppingMallList : [ShoppingMall] = []
    var shoppingMall = ShoppingMall()
    let instance = SingletonClass.shared
    var datastore: CDTStore!
    
    init() {
        self.datastore = instance.connectionSmartQDB()
        self.datastore.mapper.setDataType("ShoppingMall", forClassName: NSStringFromClass(ShoppingMall.classForCoder()))
        self.datastore.createIndexWithName("ShoppingMallIndex", fields: ["sho_id"], completionHandler: { (error:NSError!) -> Void in
        })
    }
    
    func getShoppingMallList (uiView : MallListTableViewController) -> Void {
        
        var query : CDTQuery
        query = CDTCloudantQuery(dataType: "ShoppingMall")
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
            }
            else{
                self.shoppingMallList = results as! [ShoppingMall]
                var os = NSMutableOrderedSet()
                os.addObjectsFromArray(self.shoppingMallList)
                let sd = NSSortDescriptor(key: "sho_name", ascending: true)
                os.sortUsingDescriptors([sd])
                self.shoppingMallList = os.array as! [ShoppingMall]
                uiView.shoppingMallList = self.shoppingMallList
                
                //uiView.filterContentForPriority(scope: self.segmentFilter.titleForSegmentAtIndex(self.segmentFilter.selectedSegmentIndex)!)
                //uiView.filteredListItems.sort { (item1: ShoppingMall, item2: ShoppingMall) -> Bool in
                //    return item1.sho_name.localizedCaseInsensitiveCompare(item2.sho_name) == .OrderedDescending//.OrderedAscending
                //}
                //dispatch_async(dispatch_get_main_queue(), { () -> Void in
                //    uiView.tableView.reloadData()
                //})
                
                uiView.tableView.reloadData()
            }
        })
    }
    
    func getShoppingMallList (uiView : MallListResTableViewController) -> Void {
        
        var query : CDTQuery
        query = CDTCloudantQuery(dataType: "ShoppingMall")
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
            }
            else{
                self.shoppingMallList = results as! [ShoppingMall]
                var os = NSMutableOrderedSet()
                os.addObjectsFromArray(self.shoppingMallList)
                let sd = NSSortDescriptor(key: "sho_name", ascending: true)
                os.sortUsingDescriptors([sd])
                self.shoppingMallList = os.array as! [ShoppingMall]
                uiView.shoppingMallList = self.shoppingMallList
                
                //uiView.filterContentForPriority(scope: self.segmentFilter.titleForSegmentAtIndex(self.segmentFilter.selectedSegmentIndex)!)
                //uiView.filteredListItems.sort { (item1: ShoppingMall, item2: ShoppingMall) -> Bool in
                //    return item1.sho_name.localizedCaseInsensitiveCompare(item2.sho_name) == .OrderedDescending//.OrderedAscending
                //}
                //dispatch_async(dispatch_get_main_queue(), { () -> Void in
                //    uiView.tableView.reloadData()
                //})
                
                uiView.tableView.reloadData()
            }
        })
    }
    
    func getShoppingMallById(sho_id: NSNumber, uiView : ViewGeneralInfoViewController) -> Void{
        var query : CDTQuery
        //self.queryPredicate = NSPredicate(format: "(sho_id = %@)", sho_id)!
        self.queryPredicate = NSPredicate(format: "(sho_id = %@)", sho_id)
        
        query = CDTCloudantQuery(dataType: "ShoppingMall", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
            }
            else{
                self.shoppingMallList = results as! [ShoppingMall]
                if(self.shoppingMallList.count != 1){
                    print("Found more than one restaurant [id = \(sho_id)]")
                    
                }else{
                    self.shoppingMall = self.shoppingMallList[0] as ShoppingMall
                    uiView.labelShoppingMall.text = self.shoppingMall.sho_name as String
                }
            }
            
        })
        
    }
    
    func getShoppingMallById(sho_id: NSNumber, uiView : ViewBranchViewController) -> Void{
        var query : CDTQuery
        //self.queryPredicate = NSPredicate(format: "(sho_id = %@)", sho_id)!
        self.queryPredicate = NSPredicate(format: "(sho_id = %@)", sho_id)
        
        query = CDTCloudantQuery(dataType: "ShoppingMall", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
            }
            else{
                self.shoppingMallList = results as! [ShoppingMall]
                if(self.shoppingMallList.count != 1){
                    print("Found more than one restaurant [id = \(sho_id)]")
                    
                }else{
                    self.shoppingMall = self.shoppingMallList[0] as ShoppingMall
                    uiView.labelShoppingMall.text = self.shoppingMall.sho_name as String
                }
            }
            
        })
        
    }
    
    func createItem(item: ShoppingMall) {
        self.datastore.save(item, completionHandler: { (object, error) -> Void in
            if(error != nil){
                print("updateItem failed with error \(error)")
            } else {
                self.instance.pushItems()
            }
        })
    }
    
}
