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
   private var movies: WantMovieList?
   
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
      collectionView.dataSource = self
      
      navigationController?.navigationBar.isHidden = true
      
      loadUserData()
      loadMovieData()
   }

   
   
   func setupUI() {
      let urlForimage = URL(string: userInfo?.stillImage.imageUrl ?? "")
      if let imageData = try? Data(contentsOf: urlForimage!, options: []) {
         movieImageView.image = UIImage(data: imageData)
      }
      
      let urlForprofile = URL(string: userInfo?.profileImage ?? "")
      if let imageData = try? Data(contentsOf: urlForprofile!, options: []) {
         profileImageView.image = UIImage(data: imageData)
      }
      profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
      profileImageView.clipsToBounds = true
      
      nameLabel.text = userInfo?.nickName
      timeLabel.text = "\(userInfo?.totalRunnigTime ?? 0)"
      likeLabel.text = "\(userInfo?.checkedMovieCount ?? 0)"
      commentLabel.text = "10"
   }
   
   
   func loadUserData() {
      let movieToken: HTTPHeaders = ["Authorization": "Token "+TOKEN]
      let movieUrl = API.baseURL+"api/members/\(ID)/mypage-top/"
      print("======== start load user data ========")
      print("movieUrl = ", movieUrl)
      Alamofire.request(movieUrl, method: .get, headers: movieToken)
         .validate(statusCode: 200..<300)
         .responseJSON { response in
            if let error = response.error {
               dump(error)
               return
            }
            print("success load user info")
            do {
               let data = try JSONSerialization.data(withJSONObject: response.result.value!, options: .prettyPrinted)
               let decoder: JSONDecoder = JSONDecoder()
               self.userInfo = try decoder.decode(MyPage.self, from: data)
               self.setupUI()
            } catch {
               print(error)
            }
      }
   }
   
   
   func loadMovieData() {
      let movieToken: HTTPHeaders = ["Authorization": "Token "+TOKEN]
      let movieUrl = API.baseURL+"api/members/\(ID)/want-movie/?page_size=4"
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
               self.movies = try decoder.decode(WantMovieList.self, from: data)
               self.collectionView.reloadData()
            } catch {
               print(error)
            }
      }
   }
   
   
   @IBAction func logOutButtonPressed(_ sender: UIButton) {
//      let userToken: HTTPHeaders = ["Authorization": "token "+TOKEN]
//      Alamofire.request(API.User.logout, method: .get, headers: userToken)
//         .validate(statusCode: 200..<300)
//         .responseJSON { response in
//            if let error = response.error {
//               dump(error)
//               return
//            }
//            print("success log out")
//
//
//      }
    
    
    Alamofire.request(API.User.logout).response { response in
        debugPrint(response)
        print("success log out")
    }
    
    
    }
    
   
   @objc func movieTapped(gesture : MovieTapGesture) {
      print("MyPage for movie Selected")
      print("Movie ID = ",gesture.pkForMovie)
      
      let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController
      detailVC?.pkForMovie = gesture.pkForMovie
      //detailVC?.genreName = gesture.genre
      detailVC?.genreName = "comedy"
      navigationController?.pushViewController(detailVC!, animated: true)
      
   }
   
   
   
}



//MARK: - UICollectionView Delegate, DataSource Methods
extension MyPageViewController: UICollectionViewDataSource, UICollectionViewDelegate {

   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return movies?.results.count ?? 0
   }
   
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPageCell", for: indexPath) as! MyPageCollectionViewCell
      
      let tapImageGesture = MovieTapGesture(target: self, action: #selector(self.movieTapped))
      tapImageGesture.pkForMovie = (movies?.results[indexPath.row].id)!
      tapImageGesture.genre = (movies?.results[indexPath.row].genre.first?.name)!
      
      let urlForPoster = URL(string: (movies?.results[indexPath.row].posterImage)!)
      if let imageData = try? Data(contentsOf: urlForPoster!, options: []) {
         cell.recommendMovieImage.image = UIImage(data: imageData)
      }
      cell.recommendMovieImage.addGestureRecognizer(tapImageGesture)
      
      return cell
   }
}



//MARK: - UICollectionViewDelegateFlowLayout Methods
extension MyPageViewController: UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: 75, height: 113)
   }
}
