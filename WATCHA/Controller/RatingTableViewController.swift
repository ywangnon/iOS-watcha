//
//  RatingTableViewController.swift
//  WATCHA
//
//  Created by Seo JaeHyeong on 12/04/2018.
//  Copyright © 2018 Seo Jaehyeong. All rights reserved.
//

import UIKit
import Alamofire

class MovieTapGesture: UITapGestureRecognizer {
   var pkForMovie = Int()
   var genre = String()
}

class RatingTableViewController: UITableViewController {
   
   private let TOKEN = "token \(UserDefaults.standard.string(forKey: "user_Token")!)"
   
   var movies: [RatingMovie] = []
   var pkForMoreButton: Int?
   var pkForMovieDetail: Int?
   var genreName: String = ""
   
   var urlForMovieList: String? {
      willSet(url){
         // TODO: 카테고리 pk를 가지고 서버에서 카테고리 영화리스트를 읽어와 테이블뷰 리로드 작업을 시행한다.
         print("url = ",url!)
         let userToken: HTTPHeaders = ["Authorization": TOKEN]
         Alamofire.request(url!, method: .get, headers: userToken)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
               if let error = response.error {
                  dump(error)
                  return
               }
               
               do {
                  let data = try JSONSerialization.data(withJSONObject: response.result.value!, options: .prettyPrinted)
                  let decoder: JSONDecoder = JSONDecoder()
                  self.movies = try decoder.decode(RatingMovieList.self, from: data).results
                  self.tableView.reloadData()
               } catch {
                  print(error)
               }
         }
      }
   }
   
   
    override func viewDidLoad() {
      super.viewDidLoad()
      
      loadMovieData()
      tableView.rowHeight = 100
      
    }

   
   override func viewWillDisappear(_ animated: Bool) {
      navigationController?.navigationBar.isHidden = true
   }
   
   
   override func viewWillAppear(_ animated: Bool) {
      tableView.reloadData()
      navigationController?.navigationBar.isHidden = false
   }
   
   
   
   func loadMovieData() {
   //TODO: 서버에서 가져온 영화리스트를 movies 배열에 할당하여 데이터소스에서 사용할 것
      let userToken: HTTPHeaders = ["Authorization": TOKEN]
      genreName = "action"
      Alamofire.request(API.MainPage.sortByGenre.action, method: .get, headers: userToken)
         .validate(statusCode: 200..<300)
         .responseJSON { response in
            if let error = response.error {
               dump(error)
               return
            }
            
            do {
               let data = try JSONSerialization.data(withJSONObject: response.result.value!, options: .prettyPrinted)
               let decoder: JSONDecoder = JSONDecoder()
               self.movies = try decoder.decode(RatingMovieList.self, from: data).results
               self.tableView.reloadData()
            } catch {
               print(error)
            }
      }
   }

   
   @objc func moreButtonPressed() {
      let alertVC = UIAlertController(title: "WATCHA", message: "", preferredStyle: .actionSheet)
      let likeAction = UIAlertAction(title: "보고싶어요", style: .default) { action in
         print("보고싶어요")
      }
      let commentAction = UIAlertAction(title: "코멘트", style: .default) { action in
         print("코멘트")
      }
      let myCollectionAction = UIAlertAction(title: "내 컬렉션에 담기", style: .default) { action in
         print("내 컬렉션에 담기")
      }
      let noAction = UIAlertAction(title: "관심없어요", style: .default) { action in
         print("관심없어요")
      }
      let cancleAction = UIAlertAction(title: "취소", style: .cancel) { action in
         print("취소")
      }
      alertVC.addAction(likeAction)
      alertVC.addAction(commentAction)
      alertVC.addAction(myCollectionAction)
      alertVC.addAction(noAction)
      alertVC.addAction(cancleAction)
      self.present(alertVC, animated: true, completion: nil)
   }
   
   
   @objc func categoryButtonPressed() {
      let vc = storyboard?.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
      self.modalPresentationStyle = UIModalPresentationStyle.fullScreen
      vc.view.backgroundColor = UIColor.clear
      vc.delegate = self
      
      
      self.present(vc, animated: true, completion: nil)
   }
   
   
   @objc func movieTapped(gesture : MovieTapGesture) {
      print("Rating View Cell for movie Selected")
      print("Movie ID = ",gesture.pkForMovie)
      
      let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController
      detailVC?.pkForMovie = gesture.pkForMovie
      detailVC?.genreName = genreName
      navigationController?.pushViewController(detailVC!, animated: true)

   }
   
   
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return movies.count
    }
   
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if let cell = tableView.dequeueReusableCell(withIdentifier: "RatingCell", for: indexPath) as? RatingTableViewCell {
         
         cell.cosmosView.didFinishTouchingCosmos = { rating in
            // TODO : 별점 평가하기 터치가 끝나면 해당 유저의 영화 평점을 서버에 저장한다.
            // 메인 스레드에서 하지 말것
            DispatchQueue.global().async {
               print("Success Save Movie Rating")
            }
         }
         
         let movie = movies[indexPath.row]
         print("movie = ", movie.title)
         let tapImageGesture = MovieTapGesture(target: self, action: #selector(self.movieTapped))
         tapImageGesture.pkForMovie = movie.pk
         tapImageGesture.genre = genreName

         let url = URL(string: movie.posterImage)
         if let imageData = try? Data(contentsOf: url!, options: []) {
            cell.posterImgView.image = UIImage(data: imageData)
         }
         cell.posterImgView.addGestureRecognizer(tapImageGesture)

         let tapTitleGesture = MovieTapGesture(target: self, action: #selector(self.movieTapped))
         tapTitleGesture.pkForMovie = movie.pk
         tapTitleGesture.genre = genreName
         
         cell.titleLable.text = movie.title
         cell.titleLable.addGestureRecognizer(tapTitleGesture)

         cell.yearLabel.text = "\(movie.year)"
         cell.update(0)
         
         cell.moreButton.addTarget(self, action: #selector(self.moreButtonPressed), for: .touchUpInside)
         
         return cell
      }
      return UITableViewCell()
   }
   
   
   
   override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      let width = self.view.frame.size.width
   
      let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 40))
      headerView.backgroundColor = UIColor.white
      
      let categoryButton: UIButton = UIButton(frame: CGRect(x: headerView.frame.size.width/2 - 35,
                                                    y: headerView.frame.size.height/2 - 8,
                                                    width: 70, height: 17))
      categoryButton.setTitle("카테고리", for: .normal)
      categoryButton.setTitleColor(UIColor.darkGray, for: .normal)
      categoryButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 13)
      
      categoryButton.setImage(UIImage(named: "iphone"), for: .normal)
      categoryButton.addTarget(self, action: #selector(self.categoryButtonPressed), for: .touchUpInside)
      
      headerView.addSubview(categoryButton)
      
      
      return headerView
   }
   
   
   override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      return 40.0
   }


}



extension RatingTableViewController: CategoryDelegate {   
   func passData(url: String, genre: String) {
      self.urlForMovieList = url
      self.genreName = genre
   }
}





















