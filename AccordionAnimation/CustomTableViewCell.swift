//
//  CustomTableViewCell.swift
//  AccordionAnimation
//
//  Created by Varun on 23/06/16.
//  Copyright © 2016 YMediaLabs. All rights reserved.
//

import UIKit

class CustomTableViewCell: AccordionTableViewCell {

    @IBOutlet weak var displayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
