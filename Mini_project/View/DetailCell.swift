//
//  DetailCell.swift
//  Mini_project
//
//  Created by KOTTE V S S DHEERAJ on 22/05/20.
//  Copyright © 2020 KOTTE V S S DHEERAJ. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {

    @IBOutlet weak var DetailView: UIView!
    @IBOutlet weak var DetailLabel: UILabel!

    @IBOutlet weak var location_logo: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        DetailLabel.layer.cornerRadius = DetailLabel.frame.height/2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
