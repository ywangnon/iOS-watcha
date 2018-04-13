//
//  CategoryCell.swift
//  WATCHA
//
//  Created by Seo JaeHyeong on 13/04/2018.
//  Copyright © 2018 Seo Jaehyeong. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

   @IBOutlet weak var categoryImageView: UIImageView!
   @IBOutlet weak var categoryTitleLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
