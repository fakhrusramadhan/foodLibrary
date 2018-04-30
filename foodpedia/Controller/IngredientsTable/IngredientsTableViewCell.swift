//
//  IngredientsTableViewCell.swift
//  foodpedia
//
//  Created by Fakhrus Ramadhan on 09/04/18.
//  Copyright © 2018 Fakhrus Ramadhan. All rights reserved.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lb_ingredient: UILabel!
    @IBOutlet weak var lb_value: UILabel!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
