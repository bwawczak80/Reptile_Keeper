//
//  TimestampTableViewCell.swift
//  ReptileKeeper
//
//  Created by Brian Wawczak on 11/26/19.
//  Copyright © 2019 Brian Wawczak. All rights reserved.
//

import UIKit

class TimestampTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeTag: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
