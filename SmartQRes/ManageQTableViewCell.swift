//
//  ManageQTableViewCell.swift
//  SmartQRes
//
//  Created by ninguchi on 1/4/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import UIKit

class ManageQTableViewCell: UITableViewCell {

    @IBOutlet weak var labelQueueNo: UILabel!
    @IBOutlet weak var labelNumOfPerson: UILabel!
    @IBOutlet weak var imageNumOfPerson: UIImageView!
    
    @IBOutlet weak var imageChildren: UIImageView!
    
    @IBOutlet weak var imageWheelchair: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
