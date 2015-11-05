//
//  CommonConstants.swift
//  SmartQRes
//
//  Created by ninguchi on 3/8/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import Foundation

struct Constants {
    struct AdminType {
        static let Restaurant:NSNumber = 1
        static let Branch:NSNumber = 2
    }
    struct QueueType {
        static let Client:NSNumber = 1
        static let Front:NSNumber = 2
    }
    struct QueueStatus {
        static let Waiting:NSNumber = 1
        static let Completed:NSNumber = 2
        static let NoShow:NSNumber = 3
        static let Cancelled:NSNumber = 4
    }
    struct TableType {
        static let A:String = "A"
        static let B:String = "B"
        static let C:String = "C"
        static let D:String = "D"
    }
    struct  Flag {
        static let YES:String = "Y"
        static let NO:String = "N"
    }
    struct  DecimalFormat {
        static let Queue:String = "02"
    }
    struct List {
        static let branchStatusList = ["Service", "Renovate","Stop Service", "Out Of Service"]
    }
}

extension Int {
    func format(f: String) -> String {
        return String(format: "%\(f)d", self)
    }
}
