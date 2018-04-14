//
//  CategoryCell.swift
//  WATCHA
//
//  Created by Seo JaeHyeong on 13/04/2018.
//  Copyright © 2018 Seo Jaehyeong. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

   //UITableViewController
   @IBOutlet weak var categoryImgView: UIImageView!
   @IBOutlet weak var categoryTitleLb: UILabel!
   
   //UIViewController
   @IBOutlet weak var categoryImageView: UIImageView!
   @IBOutlet weak var categoryTitleLabel: UILabel!
   

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
