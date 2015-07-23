//
//  MemesTableViewCell.swift
//  MemeGen
//
//  Created by john bateman on 6/20/15.
//  Copyright (c) 2015 John Bateman. All rights reserved.
//

import UIKit

class MemesTableViewCell: UITableViewCell {

    @IBOutlet var memeLabel: UILabel!
    @IBOutlet var memeImage: UIImageView!
    
    @IBOutlet var topImageLabel: UILabel!
    @IBOutlet var bottomImageLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
