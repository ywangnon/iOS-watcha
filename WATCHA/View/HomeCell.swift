//
//  HomeCell.swift
//  WATCHA
//
//  Created by Hansub Yoo on 2018. 4. 17..
//  Copyright © 2018년 Yoo Hansub. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {
    
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var movieTitleLabel: UILabel!
    
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var touchView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
