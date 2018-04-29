//
//  RatingTableViewCell.swift
//  WATCHA
//
//  Created by Seo JaeHyeong on 10/04/2018.
//  Copyright © 2018 Seo Jaehyeong. All rights reserved.
//

import UIKit

class RatingTableViewCell: UITableViewCell {

   
   @IBOutlet weak var posterImgView: UIImageView!
   @IBOutlet weak var titleLable: UILabel!
   @IBOutlet weak var yearLabel: UILabel!
   @IBOutlet weak var cosmosView: CosmosView!
   @IBOutlet weak var moreButton: UIButton!
   
   
//   @IBAction func moreBtnPressed(_ sender: UIButton) {
//      NotificationCenter.default.post(name: Notification.Name("More"), object: nil)
//   }
   
//
   
   func update(_ rating: Double) {
      cosmosView.rating = rating
   }
   
   
   override public func prepareForReuse() {
      cosmosView.prepareForReuse()
      print("cosmos prepareForReuse")
   }
   
}
