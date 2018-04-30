//
//  SavedFoodTableViewCell.swift
//  foodpedia
//
//  Created by Fakhrus Ramadhan on 23/04/18.
//  Copyright © 2018 Fakhrus Ramadhan. All rights reserved.
//

import UIKit

class SavedFoodTableViewCell: UITableViewCell {
    @IBOutlet weak var lb_savedName: UILabel!
    @IBOutlet weak var lb_savedCalories: UILabel!
    @IBOutlet weak var iv_savedImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
