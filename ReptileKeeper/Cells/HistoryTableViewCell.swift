//
//  HistoryTableViewCell.swift
//  ReptileKeeper
//
//  Created by Brian Wawczak on 11/26/19.
//  Copyright © 2019 Brian Wawczak. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

        
    @IBOutlet weak var tempTag: UILabel!
    @IBOutlet weak var humidityTag: UILabel!
    @IBOutlet weak var preyTag: UILabel!
    @IBOutlet weak var weightTag: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
