//
//  ProductTableViewCell.swift
//  TP_geoloc
//
//  Created by Julien Guillan on 20/11/2020.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
