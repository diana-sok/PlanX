//
//  DataStorageTableViewCell.swift
//  PlanX
//
//  Created by Diana Sok on 7/31/19.
//  Copyright © 2019 H2OT. All rights reserved.
//

import UIKit

class DataStorageTableViewCell: UITableViewCell {

    @IBOutlet weak var assignmentName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateAssignmentName(name: String) {
        assignmentName.text = name
    }

}
