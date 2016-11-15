//
//  💵Cell.swift
//  iBarber
//
//  Created by Macbook Pro on 15/11/16.
//  Copyright © 2016 Macbook Pro. All rights reserved.
//

import UIKit

class 💵Cell: UITableViewCell {
    
    @IBOutlet weak var Operation: UILabel!
    
    @IBOutlet weak var Price: UILabel!
    
    @IBOutlet weak var ClientName: UIButton!
    
    @IBOutlet weak var Total: UILabel!
    
    @IBOutlet weak var Date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
