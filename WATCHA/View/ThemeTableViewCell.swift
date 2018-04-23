//
//  ThemeTableViewCell.swift
//  WATCHA
//
//  Created by Himchan Park on 2018. 4. 18..
//  Copyright © 2018년 Seo Jaehyeong. All rights reserved.
//

import UIKit

class ThemeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var themeImageView: UIImageView!
    @IBOutlet weak var themeTitleLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
