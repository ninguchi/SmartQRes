//
//  RestaurantController.swift
//  SmartQ
//
//  Created by Worayut Traiworadecha on 2/3/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import Foundation

class RestaurantController{
    var queryPredicate:NSPredicate!
    var restaurantList : [Restaurant] = []
    var restaurant : Restaurant = Restaurant()
    let instance = SingletonClass.shared
    var datastore: CDTStore!
    
    init() {
        self.datastore = instance.connectionSmartQDB()
        self.datastore.mapper.setDataType("Restaurant", forClassName: NSStringFromClass(Restaurant.classForCoder()))
        self.datastore.createIndexWithName("RestaurantIndex", fields: ["res_id"], completionHandler: { (error:NSError!) -> Void in
        })
    }
    func getRestaurantById(res_id: NSNumber, uiView : MainDetailResViewController){
        var query : CDTQuery
        self.queryPredicate = NSPredicate(format: "(res_id = %@)", res_id)
        query = CDTCloudantQuery(dataType: "Restaurant", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
            }
            else{
                self.restaurantList = results as! [Restaurant]
                if(self.restaurantList.count != 1){
                    print("Found more than one restaurant [id = \(res_id)]")
                    
                }else{
                    self.restaurant = self.restaurantList[0] as Restaurant
                    uiView.labelRestName.text! = self.restaurant.res_name as String
                    uiView.imgRestaurant.image = UIImage(named: "\(self.restaurant.res_name).png")
                }
            }
        
        })
        
    }
    
    func getRestaurantById(res_id: NSNumber, uiView : EditBranchViewController){
        var query : CDTQuery
        self.queryPredicate = NSPredicate(format: "(res_id = %@)", res_id)
        query = CDTCloudantQuery(dataType: "Restaurant", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
            }
            else{
                self.restaurantList = results as! [Restaurant]
                print("Res List : \(self.restaurantList.count)")
                if(self.restaurantList.count != 1){
                    print("Found more than one restaurant [id = \(res_id)]")
                    
                }else{
                    self.restaurant = self.restaurantList[0] as Restaurant
                    uiView.rest = self.restaurant
                }
            }
            
        })
        
    }
    
    func getRestaurantById(res_id: NSNumber, uiView : ViewCustNotiSettingResViewController){
        var query : CDTQuery
        self.queryPredicate = NSPredicate(format: "(res_id = %@)", res_id)
        query = CDTCloudantQuery(dataType: "Restaurant", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
            }
            else{
                self.restaurantList = results as! [Restaurant]
                print("Res List : \(self.restaurantList.count)")
                if(self.restaurantList.count != 1){
                    print("Found more than one restaurant [id = \(res_id)]")
                    
                }else{
                    self.restaurant = self.restaurantList[0] as Restaurant
                    uiView.rest = self.restaurant
                    uiView.labelRound1.text! = "\(self.restaurant.res_noti_1)"
                    uiView.labelRound2.text! = "\(self.restaurant.res_noti_2)"
                    uiView.labelRound3.text! = "\(self.restaurant.res_noti_3)"
                }
            }
            
        })
        
    }
    
    func getRestaurantById(res_id : NSNumber, uiView : MasterResTableViewController) -> Void {
        var query : CDTQuery
        self.queryPredicate = NSPredicate(format: "(res_id = %@)", res_id)
        query = CDTCloudantQuery(dataType: "Restaurant", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
            }
            else{
                //self.instance.pullItems()
                self.restaurantList = results as! [Restaurant]
                if(self.restaurantList.count == 1){/*
                    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
                    imageView.contentMode = .ScaleAspectFit
                    let image = UIImage(named: self.restaurantList[0].res_name)
                    imageView.image = image
                    uiView.navigationItem.titleView = imageView*/
                    uiView.navigationItem.title = self.restaurantList[0].res_name as String
                }
            }
            
        })
        
    }

    
    func updateItem(item: Restaurant) {
        self.datastore.save(item, completionHandler: { (object, error) -> Void in
            if(error != nil){
                print("updateItem failed with error \(error)")
            } else {
                print("Update Customer Notification complete")
                self.instance.pushItems()
            }
        })
    }
    
    func getResList () -> Void {
        
        var query : CDTQuery
        query = CDTCloudantQuery(dataType: "Restaurant")
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
            }
            else{
                self.restaurantList = results as! [Restaurant]
                
                var os = NSMutableOrderedSet()
                os.addObjectsFromArray(self.restaurantList)
                let sd = NSSortDescriptor(key: "res_id", ascending: true)
                os.sortUsingDescriptors([sd])
                self.restaurantList = os.array as! [Restaurant]
                for item in self.restaurantList {
                    print("res id \(item.res_id) res_name \(item.res_name)" )
                }
            }
        })
    }



}
