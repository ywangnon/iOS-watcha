//
//  HomeViewController.swift
//  WATCHA
//
//  Created by Hansub Yoo on 2018. 4. 17..
//  Copyright © 2018년 Seo Jaehyeong. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var HometableView: UITableView!
    
    let strToken = UserDefaults.standard.string(forKey: "user_Token")
    
    var result: TopMovies!
    var searchResult: SearchMovie!
    var movies: [Top5] = []
    var SearchMovies: [SearchMovie.movie] = []
    
    var searchBool: Bool = false
    
    @objc func movieTapped(gesture : MovieTapGesture) {
        print("Rating View Cell for movie Selected")
        let tagForMovie = gesture.pkForMovie
        print("Movie Tag = ",tagForMovie)
        
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController
        detailVC?.pkForMovie = tagForMovie
        
        navigationController?.pushViewController(detailVC!, animated: true)
        
    }
    
    func loadMovieData() {
        //TODO : 서버에서 가져온 영화리스트를 movies 배열에 할당하여 데이터소스에서 사용할 것
        guard let token = strToken else { return }
        
        print("\n---------- [ header ] ----------\n")
        let headerToken = "token " + token
        print(headerToken)
        
        let userToken: HTTPHeaders = ["Authorization": headerToken]
        
        print("\n---------- [ url ] ----------\n")
        
        Alamofire.request(API.MainPage.Top5Movie, method: .get, headers: userToken)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if let error = response.error {
                    print("\n---------- [ error3 ] ----------\n")
                    dump(error)
                    return
                }
                
                do {
                    print("\n---------- [ JSONSerialization ] ----------\n")
                    let data = try JSONSerialization.data(withJSONObject: response.result.value!, options: .prettyPrinted)
                    print(data)
                    let decoder: JSONDecoder = JSONDecoder()
                    print(decoder)
                    self.result = try decoder.decode(TopMovies.self, from: data)
                    self.movies = self.result.results
                    print(self.movies)
                    self.HometableView.reloadData()
                } catch {
                    print("\n---------- [ error4 ] ----------\n")
                    print(error)
                }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBool {
            return SearchMovies.count
        } else {
            return movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.HometableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        
        if searchBool {
            
            let movie = SearchMovies[indexPath.row]
            let tapImageGesture = MovieTapGesture(target: self, action: #selector(self.movieTapped))
            tapImageGesture.pkForMovie = movie.id
            
            
            let url = URL(string: movie.poster_image)
            if let imageData = try? Data(contentsOf: url!, options: []) {
                cell.movieImage.image = UIImage(data: imageData)
            }
            cell.movieImage.isUserInteractionEnabled = true
            cell.movieImage.addGestureRecognizer(tapImageGesture)
            
            cell.movieTitleLabel.text = movie.title_ko
            cell.ratingLabel.text = "0.0"
            
        } else {
            
            let movie = movies[indexPath.row]
            let tapImageGesture = MovieTapGesture(target: self, action: #selector(self.movieTapped))
            tapImageGesture.pkForMovie = movie.id
            
            let url = URL(string: movie.posterImageX3)
            if let imageData = try? Data(contentsOf: url!, options: []) {
                cell.movieImage.image = UIImage(data: imageData)
            }
            cell.movieImage.isUserInteractionEnabled = true
            cell.movieImage.addGestureRecognizer(tapImageGesture)
            
            cell.movieTitleLabel.text = movie.title
            cell.ratingLabel.text = movie.averageRate
            
        }
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMovieData()
        
        searchTextField.delegate = self
        
        HometableView.delegate = self
        HometableView.rowHeight = 256
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 엔터치면 검색
    /// (현재 2번 쳐야 검색됨)
    /// - Parameter textField: 텍스트필드
    /// - Returns: 눌렸는지 안 눌렸는지
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField.isEqual(self.searchTextField)){ //titleField에서 리턴키를 눌렀다면
            
            print("\n---------- [ Search ] ----------\n")
            
            print("\n---------- [ header ] ----------\n")
            guard let token = strToken, let searchWord = searchTextField.text else { return false }
            
            let headerToken = "token " + token
            let userToken: HTTPHeaders = ["Authorization": headerToken]
            print(headerToken)
            
            let url = "https://justdo2t.com/api/movie/search/?movie=\(searchWord)" //"&page_size=3"
            
            Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: userToken)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    if let error = response.error {
                        print("\n---------- [ error3 ] ----------\n")
                        dump(error)
                        return
                    }
                    
                    do {
                        print("\n---------- [ Search JSONSerialization ] ----------\n")
                        let data = try JSONSerialization.data(withJSONObject: response.result.value!, options: .prettyPrinted)
                        print(data)
                        let decoder: JSONDecoder = JSONDecoder()
                        print(decoder)
                        self.searchResult = try decoder.decode(SearchMovie.self, from: data)
                        self.SearchMovies = self.searchResult.results
                        print(self.SearchMovies)
//                        self.HometableView.reloadData()
                    } catch {
                        print("\n---------- [ error4 ] ----------\n")
                        print(error)
                    }
            }
            searchBool = true
            HometableView.reloadData()
        }
        return true
    }
    
}
