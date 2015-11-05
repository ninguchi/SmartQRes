//
//  Branch.swift
//  SmartQ
//
//  Created by Worayut Traiworadecha on 2/3/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

@objc public class Branch : NSObject, CDTDataObject {
    
    var bra_id : NSNumber = 0
    var bra_res_id : NSNumber = 0
    var bra_sho_id : NSNumber = 0
    var bra_name : NSString = ""
    var bra_status : NSNumber = 0
    var bra_location : NSString = ""
    var bra_service_time : NSString = ""
    var bra_contact_no : NSString = ""
    var bra_ty_a_min : NSNumber = 0
    var bra_ty_a_max : NSNumber = 4
    var bra_ty_a_turnover : NSNumber = 3
    var bra_ty_b_min : NSNumber = 5
    var bra_ty_b_max : NSNumber = 8
    var bra_ty_b_turnover : NSNumber = 6
    var bra_ty_c_min : NSNumber = 9
    var bra_ty_c_max : NSNumber = 12
    var bra_ty_c_turnover : NSNumber = 8
    var bra_ty_d_min : NSNumber = 13
    var bra_ty_d_max : NSNumber = 20
    var bra_ty_d_turnover : NSNumber = 10

    var bra_noti_1 : NSNumber = 0
    var bra_noti_2 : NSNumber = 0
    var bra_noti_3 : NSNumber = 0
    
    var bra_res_name : NSString = ""
    
    public var metadata:CDTDataObjectMetadata?

    
    
}