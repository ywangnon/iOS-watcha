//
//  MovieDetailViewController.swift
//  WATCHA
//
//  Created by Seo JaeHyeong on 09/04/2018.
//  Copyright © 2018 Seo Jaehyeong. All rights reserved.
//

import UIKit
import Alamofire

class MovieDetailViewController: UIViewController {
   
   //for test temporary toket
   //private let TOKEN = "token \(UserDefaults.standard.string(forKey: "user_Token")!)"
   private let TOKEN = "token 89388cd52f32a2dd1fb3b18ba26e3c7830937968"
   
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
   
   var pkForMovie: Int = 0 {
      willSet {
         // TODO : 카테고리 pk를 가지고 서버에서 카테고리 영화정보를 읽어온다.
         print("update movie Info")
      }
   }
   
   
    override func viewDidLoad() {
      super.viewDidLoad()
      
      registerDelegate()
      loadMovieData(with: pkForMovie)
    }
   
   
   private func loadMovieData(with key: Int) {
      
   }
   
   
   
   func registerDelegate() {
      actorCollectionView.delegate = self
      actorCollectionView.dataSource = self
      
      galleryCollectionView.delegate = self
      galleryCollectionView.dataSource = self
      
      youtubeCollectionView.delegate = self
      youtubeCollectionView.dataSource = self
      
      commentTableView.delegate = self
      commentTableView.dataSource = self
      
      recommendCollectionView.delegate = self
      recommendCollectionView.dataSource = self
   }
   

   @IBAction func backButtonPressed(_ sender: UIButton) {
      navigationController?.popViewController(animated: true)
   }
   
   
   //보고싶어요 버튼 클릭시 액션 정의
   @IBAction func wantButtonPressed(_ sender: UIButton) {
   }
 
   
   //평가하기 버튼 클릭시 액션 정의
   @IBAction func rateButtonPressed(_ sender: UIButton) {
   }
   

   //코멘트 버튼 클릭시 액션 정의
   @IBAction func commentButtonPressed(_ sender: UIButton) {
   }
   
   
   //더보기 버튼 클릭시 액션 정의
   @IBAction func moreButtonPressed(_ sender: UIButton) {
   }
   
}



//MARK: - UICollectionView Delegate, DataSource Methods
extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      var counts = 0
      
      switch collectionView {
      case actorCollectionView:
         counts = 5
      case galleryCollectionView:
         counts = 5
      case youtubeCollectionView:
         counts = 5
      case recommendCollectionView:
         counts = 5
      default:
         counts = 1
      }

      return counts
   }
   
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
      switch collectionView {
      case actorCollectionView:
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActorCell", for: indexPath) as! ActorCollectionViewCell
         return cell
      case galleryCollectionView:
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as! GalleryCollectionViewCell
         return cell
      case youtubeCollectionView:
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YoutubeCell", for: indexPath) as! YoutubeCollectionViewCell
         return cell
      case recommendCollectionView:
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCell", for: indexPath) as! RecommendCollectionViewCell
         return cell
      default:
         print("Fail Select Cell")
      }
      
      return UICollectionViewCell()
   }
   
   
}



//MARK: - UITableView Delegate, DataSource Methods
extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 3
   }
   
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = commentTableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTableViewCell
      
      return cell
   }
   
   
}






















