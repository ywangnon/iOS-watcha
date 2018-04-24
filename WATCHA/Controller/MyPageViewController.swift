//
//  MyPageViewController.swift
//  WATCHA
//
//  Created by Seo JaeHyeong on 23/04/2018.
//  Copyright © 2018 Seo Jaehyeong. All rights reserved.
//

import UIKit
import Alamofire

class MyPageViewController: UIViewController {
   
   private let TOKEN = "\(UserDefaults.standard.string(forKey: "user_Token")!)"
   private let ID = "\(UserDefaults.standard.string(forKey: "#$id8461038765")!)"
   
   private var userInfo: MyPage?
   @IBOutlet weak var movieImageView: UIImageView!
   @IBOutlet weak var profileImageView: UIImageView!
   @IBOutlet weak var nameLabel: UILabel!
   @IBOutlet weak var timeLabel: UILabel!
   @IBOutlet weak var likeLabel: UILabel!
   @IBOutlet weak var commentLabel: UILabel!
   
   @IBOutlet weak var collectionView: UICollectionView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      collectionView.delegate = self
      
      loadData()
   }

   
   func loadData() {
      let movieToken: HTTPHeaders = ["Authorization": "Token "+TOKEN]
      let movieUrl = API.baseURL+"api/members/\(ID)/mypage-top/"
      print("======== start load movie data ========")
      print("movieUrl = ", movieUrl)
      Alamofire.request(movieUrl, method: .get, headers: movieToken)
         .validate(statusCode: 200..<300)
         .responseJSON { response in
            if let error = response.error {
               dump(error)
               return
            }
            print("success load movie info")
            do {
               let data = try JSONSerialization.data(withJSONObject: response.result.value!, options: .prettyPrinted)
               let decoder: JSONDecoder = JSONDecoder()
               self.userInfo = try decoder.decode(MyPage.self, from: data)
            } catch {
               print(error)
            }
      }
   }
   
}



//MARK: - UICollectionView Delegate, DataSource Methods
extension MyPageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return 4
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as! GalleryCollectionViewCell
      
      return cell
   }
}



//MARK: - UICollectionViewDelegateFlowLayout Methods
extension MyPageViewController: UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: 75, height: 113)
   }
}
