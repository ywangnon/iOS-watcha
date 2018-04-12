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
   var pkForMoreButton: String?
   
   //For Test
   private static var rowsCount = 100
   private var ratingStorage = [Double](repeating: 0, count: rowsCount)
   
    override func viewDidLoad() {
        super.viewDidLoad()

      tableView.rowHeight = 100
      loadMovieData()
      
      for i in 0..<RatingTableViewController.rowsCount {
            ratingStorage[i] = Double(i) / 99 * 5
      }

    }

   func loadMovieData() {
   //TODO : 서버에서 가져온 영화리스트를 movies 배열에 할당하여 데이터소스에서 사용할 것
      
   //테스트 데이터들
      var movie1 = RatingMovie()
      movie1.moviePk = "1"
      movie1.movieRate = 1.0
      movies.append(movie1)
      
      var movie2 = RatingMovie()
      movie2.moviePk = "2"
      movie2.movieRate = 2.0
      movies.append(movie2)
      
      var movie3 = RatingMovie()
      movie3.moviePk = "3"
      movie3.movieRate = 3.0
      movies.append(movie3)
      
      var movie4 = RatingMovie()
      movie4.moviePk = "4"
      movie4.movieRate = 4.0
      movies.append(movie4)
      
      var movie5 = RatingMovie()
      movie5.moviePk = "5"
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
   
   
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ratingStorage.count
    }
   
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if let cell = tableView.dequeueReusableCell(withIdentifier: "RatingCell", for: indexPath) as? RatingTableViewCell {
         let rating = ratingStorage[indexPath.row]
         cell.update(rating)
         
         cell.cosmosView.didFinishTouchingCosmos = { [weak self] rating in
            self?.ratingStorage[indexPath.row] = rating
         }
         
            //let movie = movies[indexPath.row]
            //         cell.posterImgView.image = UIImage(named: movie.movieImage)
            //         //cell.imageView?.image = UIImage(named: "watcha")
            //         cell.titleLable.text = movie.movieTitle
            //         cell.yearLabel.text = movie.movieYear
            //         cell.cosmosView.rating = movie.movieRate
            
            cell.posterImgView.image = UIImage(named: "ready_player_one")
            //cell.imageView?.image = UIImage(named: "ready_player_one")
            cell.titleLable.text = "레디 플레이어 원"
            cell.yearLabel.text = "2018"
            
            cell.cosmosView.settings.fillMode = .half
            
            //pkForMoreButton = movie.moviePk
            
            cell.moreButton.addTarget(self, action: #selector(self.moreButtonPressed), for: .touchUpInside)
         
         return cell
      }
      return UITableViewCell()
   }
   
   
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      print("selected row : ",indexPath.row)
      
      let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController")
      //detailVC?.modalTransitionStyle = .crossDissolve
      navigationController?.pushViewController(detailVC!, animated: true)
      //present(detailVC!, animated: true, completion: nil)
   }


}




















