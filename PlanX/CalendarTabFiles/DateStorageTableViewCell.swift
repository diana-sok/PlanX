//
//  DateStorageTableViewCell.swift
//  PlanX
//
//  Created by Roshini  Malempati  on 7/18/19.
//  Copyright © 2019 H2OT. All rights reserved.
//

import UIKit

class DateStorageTableViewCell: UITableViewCell {

    @IBOutlet weak var ClndrStrDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        ClndrStrDateLabel.text = dateString
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
