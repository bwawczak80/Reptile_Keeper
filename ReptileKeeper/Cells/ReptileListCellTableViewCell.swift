//
//  ReptileListCellTableViewCell.swift
//  ReptileKeeper
//
//  Created by Brian Wawczak on 11/7/19.
//  Copyright © 2019 Brian Wawczak. All rights reserved.
//

import UIKit

class ReptileListCellTableViewCell: UITableViewCell {
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelNameTag: UILabel!
    @IBOutlet weak var labelSpeciesTag: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

    }
    
    
}
