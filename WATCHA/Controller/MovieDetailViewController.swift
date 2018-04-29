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
   
   private let TOKEN = "token \(UserDefaults.standard.string(forKey: "user_Token")!)"
   
   private var movie: MovieDetailInfo?
   private var recommendMovies: [RatingMovie] = []
   private var actors: [ActorType] = []
   
   var genreName: String = ""
   
   @IBOutlet weak var actorCollectionView: UICollectionView!
   @IBOutlet weak var galleryCollectionView: UICollectionView!
   @IBOutlet weak var youtubeCollectionView: UICollectionView!
   @IBOutlet weak var commentTableView: UITableView!
   @IBOutlet weak var recommendCollectionView: UICollectionView!
   @IBOutlet weak var commentView: UIView!
   
   @IBOutlet weak var backgroundImageView: UIImageView!
   @IBOutlet weak var posterImageView: UIImageView!
   @IBOutlet weak var titleLabel: UILabel!
   @IBOutlet weak var infoLabel: UILabel!
   @IBOutlet weak var ratedPointLabel: UILabel!
   @IBOutlet weak var cosmosView: CosmosView!
   @IBOutlet weak var storyLabel: UILabel!
   
   var pkForMovie: Int = 0 {
      didSet {
         // TODO: 카테고리 pk를 가지고 서버에서 카테고리 영화정보를 읽어온다.
         print("======== start update movie Info ========")
         print("pkForMovie = ",pkForMovie)
         let userToken: HTTPHeaders = ["Authorization": TOKEN]
         let url = API.Movie.detail + "\(pkForMovie)/"
         Alamofire.request(url, method: .get, headers: userToken)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
               if let error = response.error {
                  dump(error)
                  return
               }
               
               do {
                  let data = try JSONSerialization.data(withJSONObject: response.result.value!, options: .prettyPrinted)
                  let decoder: JSONDecoder = JSONDecoder()
                  self.movie = try decoder.decode(MovieDetailInfo.self, from: data)
                  self.setupUI()
               } catch {
                  print(error)
               }
         }
      }
   }
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      commentTableView.separatorStyle = .none
      registerDelegate()
   }
   
   
   override func viewDidAppear(_ animated: Bool) {
      loadRecommendMovies()
   }
   
   
   
   //MARK: - API Call, Data Load, Setting UI Methods
   func loadRecommendMovies() {
      print("======== start load recommend movies Info ========")
      print("recommend genre = ",genreName)
      if genreName == "" {
         genreName = "top-world"
      }
      let userToken: HTTPHeaders = ["Authorization": TOKEN]
      let url = API.Movie.detail + "\(typeOf(genreName))/\(genreName)/"
      Alamofire.request(url, method: .get, headers: userToken)
         .validate(statusCode: 200..<300)
         .responseJSON { response in
            if let error = response.error {
               dump(error)
               return
            }
            
            do {
               let data = try JSONSerialization.data(withJSONObject: response.result.value!, options: .prettyPrinted)
               let decoder: JSONDecoder = JSONDecoder()
               self.recommendMovies = try decoder.decode(RatingMovieList.self, from: data).results
               self.setupUI()
            } catch {
               print(error)
            }
      }
   }
   
   
   func typeOf(_ type: String) -> String {
      let tags = ["top-korea", "million-seller", "top-world", "hero", "sports", "family"]
      for tag in tags {
         if tag == genreName {
            return "tag"
         }
      }
      return "genre"
   }
   
   
   func setupUI() {
      let urlForBackground = URL(string: movie?.stillCuts?.first?.image ?? "")
      if let imageData = try? Data(contentsOf: urlForBackground!, options: []) {
         backgroundImageView.image = UIImage(data: imageData)
      }
      
      let urlForPoster = URL(string: movie?.posterImageWeb ?? "")
      if let imageData = try? Data(contentsOf: urlForPoster!, options: []) {
         posterImageView.image = UIImage(data: imageData)
      }
      
      guard let title = movie?.titleKorean else {return}
      titleLabel.text = title
      
      var year: String = ""
      if let yearTotal = movie?.year {
         year = String(yearTotal.prefix(4))
      }
      
      guard let nation = movie?.nation else {return}
      guard let genre = movie?.genre?.first?.name else {return}
      guard let time = movie?.playTime else {return}
      let infoText: String = "\(year)・\(nation)・\(genre)・\(time)분"
      infoLabel.text = infoText
      
      guard let point = movie?.averageRating else {return}
      ratedPointLabel.text = point
      cosmosView.settings.fillMode = .precise
      cosmosView.rating = Double(point)!
      
      guard let story = movie?.story else {return}
      guard let grade = movie?.filmRate else {return}
      guard let titleEn = movie?.titleEnglish else {return}
      storyLabel.text = """
      상세정보
      \(grade)・\(titleEn)
      \(infoText)
      \(story)
      """
      
      if let member = movie?.actors {
         for actor in member.reversed() {
            actors.append(actor)
         }
      }
      
      actorCollectionView.reloadData()
      galleryCollectionView.reloadData()
      youtubeCollectionView.reloadData()
      commentTableView.reloadData()
      recommendCollectionView.reloadData()
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
   
   
   
   //MARK: - Button Action Methods
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
      var textField = UITextField()
      
      let commentVC = UIAlertController(title: "코멘트 추가", message: "", preferredStyle: .alert)
      let commentAction = UIAlertAction(title: "확인", style: .default, handler: { action in
      
         if let text = textField.text {
            self.registerComment(with: text, id: sender.tag)
         }
      })
      commentVC.addTextField { commentTf in
         textField.placeholder = "코멘트를 입력하세요"
         textField = commentTf
      }
      commentVC.addAction(commentAction)
      self.present(commentVC, animated: true, completion: nil)
   }
   
   
   //더보기 버튼 클릭시 액션 정의
   @IBAction func moreButtonPressed(_ sender: UIButton) {
   }
   
   
   //코멘트 등록
   func registerComment(with text: String, id: Int) {
      DispatchQueue.global().async {
         print("===== Start Save comment =====")
         let userToken = "Token \(UserDefaults.standard.string(forKey: "user_Token")!)"
         let userHeaders: HTTPHeaders = ["Content-Type": "application/json", "Authorization": userToken]
         let params: Parameters = [
            "user_want_movie": false,
            "user_watched_movie": false,
            "rating": 0.0,
            "comment": text,
            "movie": id
         ]
         
         Alamofire.request(API.MyPage.checkCreate, method: .post, parameters: params, encoding: JSONEncoding.default , headers: userHeaders)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
               if let error = response.error {
                  dump(error)
                  return
               }
               print("Success Save Comment")
         }
      }
   }
   
}



//MARK: - UICollectionView Delegate, DataSource Methods
extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      var counts = 0
      
      switch collectionView {
      case actorCollectionView:
         counts = movie?.actors.count ?? 0
      case galleryCollectionView:
         counts = movie?.stillCuts?.count ?? 0
      case youtubeCollectionView:
         counts = movie?.youtubeUrls?.count ?? 0
      case recommendCollectionView:
         if recommendMovies.count > 1 {
            counts = recommendMovies.count - 1
         } else {
            print("No count recommend movies")
         }
      default:
         print("No Selection number Of Items In Section")
      }
      return counts
   }
   
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
      switch collectionView {
      case actorCollectionView:
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActorCell", for: indexPath) as! ActorCollectionViewCell
         
         let who = actors[indexPath.row]
         let urlForActor = URL(string: who.actor.profileImage)
         if let imageData = try? Data(contentsOf: urlForActor!, options: []) {
            cell.actorImageView.image = UIImage(data: imageData)
            cell.actorImageView.layer.cornerRadius = 10
            cell.actorImageView.clipsToBounds = true
         }
         
         let name = who.actor.name
         let type = who.type
         if var position = who.position {
            position = "/" + position
         }
         cell.nameLabel.text = name
         cell.positionLabel.text = type
         
         return cell
      case galleryCollectionView:
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as! GalleryCollectionViewCell
         
         let urlForimage = URL(string: movie?.stillCuts?[indexPath.row].image ?? "")
         if let imageData = try? Data(contentsOf: urlForimage!, options: []) {
            cell.movieImage.image = UIImage(data: imageData)
         }
         
         return cell
      case youtubeCollectionView:
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YoutubeCell", for: indexPath) as! YoutubeCollectionViewCell
         
         let urlForThumbNail = URL(string: movie?.youtubeUrls?[indexPath.row].urlThumbNail ?? "")
         if let imageData = try? Data(contentsOf: urlForThumbNail!, options: []) {
            cell.thumbnailImage.image = UIImage(data: imageData)
         }
         cell.titleLabel.text = movie?.youtubeUrls?[indexPath.row].title
         
         return cell
      case recommendCollectionView:
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCell", for: indexPath) as! RecommendCollectionViewCell
         
         let urlForPoster = URL(string: recommendMovies[indexPath.row].posterImage)
         if let imageData = try? Data(contentsOf: urlForPoster!, options: []) {
            cell.posterImageView.image = UIImage(data: imageData)
         }
         cell.titleLabel.text = recommendMovies[indexPath.row].title
         
         return cell
      default:
         print("Fail Select Cell")
      }
      
      return UICollectionViewCell()
   }
   
}



//MARK: - UICollectionViewDelegateFlowLayout Methods
extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
      switch collectionView {
      case actorCollectionView:
         print("actorCollectionView")
         return CGSize(width: 90, height: 180)
      case galleryCollectionView:
         return CGSize(width: 130, height: 100)
      case youtubeCollectionView:
         return CGSize(width: 350, height: 78)
      case recommendCollectionView:
         return CGSize(width: 97, height: 155)
      default:
         print("Fail Select collectionView in UICollectionViewDelegateFlowLayout")
      }
      return CGSize()
   }
}




//MARK: - UITableView Delegate, DataSource Methods
extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return movie?.comments?.count ?? 0
   }
   
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = commentTableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTableViewCell
      
      if let comment = movie?.comments?[indexPath.row] {
         if let image = comment.user.profileImage {
            let urlForProfile = URL(string: image)
            if let imageData = try? Data(contentsOf: urlForProfile!, options: []) {
               cell.profileImageView.image = UIImage(data: imageData)
            }
         }
         cell.nameLabel.text = comment.user.nickName
         cell.cosmosView.rating = Double(comment.rating)!
         cell.yearLabel.text = String(comment.updatedDate.prefix(10))
         cell.commentLabel.text = comment.comment
      }
      
      return cell
   }
   
   
}
