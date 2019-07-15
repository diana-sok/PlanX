//
//  HomeTableViewCell.swift
//  PlanX
//
//  Created by Diana Sok on 7/9/19.
//  Copyright © 2019 H2OT. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var toDoListCheckButton: UIButton!
    @IBOutlet weak var toDoListItemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func toDoListCheckButtonTapped(_ sender: UIButton) {
        
        if toDoListCheckButton.currentBackgroundImage != UIImage(named: "icons8-checkmark-30") {
            toDoListCheckButton.setBackgroundImage(UIImage(named: "icons8-checkmark-30"), for: .normal)
        }
        else {
            toDoListCheckButton.setBackgroundImage(nil, for: .normal)
        }
    }
}
