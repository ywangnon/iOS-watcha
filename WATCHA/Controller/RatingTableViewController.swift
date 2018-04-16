//
//  RatingTableViewController.swift
//  WATCHA
//
//  Created by Seo JaeHyeong on 12/04/2018.
//  Copyright © 2018 Seo Jaehyeong. All rights reserved.
//

import UIKit

class RatingTableViewController: UITableViewController {

   var movies: [RatingMovie] = []
   var pkForMoreButton: Int?
   var pkForMovieDetail: Int?
   var pkForCategory: Int? {
      willSet {
         // TODO : 카테고리 pk를 가지고 서버에서 카테고리 영화리스트를 읽어와 테이블뷰 리로드 작업을 시행한다.
      }
   }
   
   //For Test
//   private static var rowsCount = 100
//   private var ratingStorage = [Double](repeating: 0, count: rowsCount)
   
    override func viewDidLoad() {
        super.viewDidLoad()

      tableView.rowHeight = 100
      loadMovieData()
      
//      for i in 0..<RatingTableViewController.rowsCount {
//            ratingStorage[i] = Double(i) / 99 * 5
//      }

    }

   func loadMovieData() {
   //TODO : 서버에서 가져온 영화리스트를 movies 배열에 할당하여 데이터소스에서 사용할 것
      
   //테스트 데이터들
      var movie1 = RatingMovie()
      movie1.moviePk = 1
      movie1.movieRate = 1.0
      movies.append(movie1)
      
      var movie2 = RatingMovie()
      movie2.moviePk = 2
      movie2.movieRate = 2.0
      movies.append(movie2)
      
      var movie3 = RatingMovie()
      movie3.moviePk = 3
      movie3.movieRate = 3.0
      movies.append(movie3)
      
      var movie4 = RatingMovie()
      movie4.moviePk = 4
      movie4.movieRate = 4.0
      movies.append(movie4)
      
      var movie5 = RatingMovie()
      movie5.moviePk = 5
      movie5.movieRate = 5.0
      movies.append(movie5)
      
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
      let vc = storyboard?.instantiateViewController(withIdentifier: "CategoryViewController")
      //let vc = storyboard?.instantiateViewController(withIdentifier: "CategoryTableViewController")
      //let vc = CategoryTableViewController()
      self.modalPresentationStyle = UIModalPresentationStyle.fullScreen
      vc?.view.backgroundColor = UIColor.clear
      
      self.present(vc!, animated: true, completion: nil)
   }
   
   
   @objc func movieTapped(gesture : MovieTapGesture) {
      print("Rating View Cell for movie Selected")
      let tagForMovie = gesture.pkForMovie
      print("Movie Tag = ",tagForMovie)
      
      let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController
      detailVC?.pkForMovie = tagForMovie
      
      navigationController?.pushViewController(detailVC!, animated: true)
   

   }
   
   
   
   
   
   
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }
   
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if let cell = tableView.dequeueReusableCell(withIdentifier: "RatingCell", for: indexPath) as? RatingTableViewCell {
//         let rating = ratingStorage[indexPath.row]
//         cell.update(rating)
         
         cell.cosmosView.didFinishTouchingCosmos = { rating in
            // TODO : 별점 평가하기 터치가 끝나면 해당 유저의 영화 평점을 서버에 저장한다.
            // 메인 스레드에서 하지 말것
            DispatchQueue.global().async {
               print("Success Save Movie Rating")
            }
         }
         
         let movie = movies[indexPath.row]
      
         let tapImageGesture = MovieTapGesture(target: self, action: #selector(self.movieTapped))
         tapImageGesture.pkForMovie = movie.moviePk
      
         cell.posterImgView.image = UIImage(named: movie.movieImage)
         cell.posterImgView.addGestureRecognizer(tapImageGesture)
      
         let tapTitleGesture = MovieTapGesture(target: self, action: #selector(self.movieTapped))
         tapTitleGesture.pkForMovie = movie.moviePk
         
         cell.titleLable.text = movie.movieTitle
         cell.titleLable.addGestureRecognizer(tapTitleGesture)
      
         cell.yearLabel.text = movie.movieYear
         cell.update(movie.movieRate)
            
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


class MovieTapGesture: UITapGestureRecognizer {
   var pkForMovie = Int()
}



















