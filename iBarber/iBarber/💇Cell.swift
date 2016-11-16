//
//  💇Cell.swift
//  iBarber
//
//  Created by Macbook Pro on 16/11/16.
//  Copyright © 2016 Macbook Pro. All rights reserved.
//

import UIKit

class 💇Cell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var PhoneLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
