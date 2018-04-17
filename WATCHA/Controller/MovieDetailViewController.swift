//
//  MovieDetailViewController.swift
//  WATCHA
//
//  Created by Seo JaeHyeong on 09/04/2018.
//  Copyright © 2018 Seo Jaehyeong. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
   
   
   @IBOutlet weak var actorCollectionView: UICollectionView!
   @IBOutlet weak var galleryCollectionView: UICollectionView!
   @IBOutlet weak var youtubeCollectionView: UICollectionView!
   @IBOutlet weak var commentTableView: UITableView!
   @IBOutlet weak var recommendCollectionView: UICollectionView!
   
   @IBOutlet weak var backgroundImageView: UIImageView!
   @IBOutlet weak var posterImageView: UIImageView!
   @IBOutlet weak var titleLabel: UILabel!
   @IBOutlet weak var infoLabel: UILabel!
   @IBOutlet weak var ratedPointLabel: UILabel!
   @IBOutlet weak var cosmosView: CosmosView!
   
   
   var pkForMovie: Int? {
      willSet {
         // TODO : 카테고리 pk를 가지고 서버에서 카테고리 영화정보를 읽어온다.
         print("update movie Info")
      }
   }
   
    override func viewDidLoad() {
      super.viewDidLoad()
      
    }
   

   @IBAction func backButtonPressed(_ sender: UIButton) {
      navigationController?.popViewController(animated: true)
   }
   
   
   @IBAction func wantButtonPressed(_ sender: UIButton) {
   }
 
   
   @IBAction func rateButtonPressed(_ sender: UIButton) {
   }
   

   @IBAction func commentButtonPressed(_ sender: UIButton) {
   }
   
   
   @IBAction func moreButtonPressed(_ sender: UIButton) {
   }
   
}
