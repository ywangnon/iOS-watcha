//
//  ThemeDetailTableViewCell.swift
//  WATCHA
//
//  Created by Himchan Park on 2018. 4. 18..
//  Copyright © 2018년 Seo Jaehyeong. All rights reserved.
//

import UIKit

class ThemeDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var averageRatingLabel: UILabel!
    @IBOutlet weak var depositAndBoxOfficeLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
