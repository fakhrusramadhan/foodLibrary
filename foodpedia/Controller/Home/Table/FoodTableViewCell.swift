//
//  FoodTableViewCell.swift
//  foodpedia
//
//  Created by Fakhrus Ramadhan on 04/04/18.
//  Copyright © 2018 Fakhrus Ramadhan. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var iv_foodImage: UIImageView!
    @IBOutlet weak var lb_foodTitle: UILabel!
    @IBOutlet weak var lb_foodCalories: UILabel!
    @IBOutlet weak var v_foodCell: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
