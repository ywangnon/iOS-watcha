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
    
    var result: HomeMovies!
    var searchResult: SearchMovie!
    var movies: [HomeMovie] = []
    var SearchMovies: [SearchMovie.movie] = []
    
    var searchBool: Bool = false
    
    var urlForMovieList: String? {
        willSet(url){
            // TODO : 카테고리 pk를 가지고 서버에서 카테고리 영화리스트를 읽어와 테이블뷰 리로드 작업을 시행한다.
            print("\n---------- [ url ] ----------\n")
            print("url = ",url!)
            
            guard let token = strToken else { return }
            
            let headerToken = "token " + token
            print("\n---------- [ header ] ----------\n")
            print(headerToken)
            
            let userToken: HTTPHeaders = ["Authorization": headerToken]
            Alamofire.request(url!, method: .get, headers: userToken)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    if let error = response.error {
                        print("\n---------- [ error1 ] ----------\n")
                        dump(error)
                        return
                    }
                    
                    do {
                        let data = try JSONSerialization.data(withJSONObject: response.result.value!, options: .prettyPrinted)
                        print(data)
                        let decoder: JSONDecoder = JSONDecoder()
                        print(decoder)
                        self.result = try decoder.decode(HomeMovies.self, from: data)
                        self.movies = self.result.results
                        print(self.movies)
                        self.HometableView.reloadData()
                    } catch {
                        print("\n---------- [ error2 ] ----------\n")
                        print(error)
                    }
            }
        }
    }
    
    func loadMovieData() {
        //TODO : 서버에서 가져온 영화리스트를 movies 배열에 할당하여 데이터소스에서 사용할 것
        guard let token = strToken else { return }
        
        let headerToken = "token " + token
        print("\n---------- [ header ] ----------\n")
        print(headerToken)
        
        let userToken: HTTPHeaders = ["Authorization": headerToken]
        
        Alamofire.request("https://justdo2t.com/api/movie/genre/action/", method: .get, headers: userToken)
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
                    self.result = try decoder.decode(HomeMovies.self, from: data)
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
        
        if searchBool == false {
            
            let movie = movies[indexPath.row]
            let url = URL(string: movie.posterImageX3)
            if let imageData = try? Data(contentsOf: url!, options: []) {
                cell.movieImage.image = UIImage(data: imageData)
            }
            cell.movieTitleLabel.text = movie.title
            cell.ratingLabel.text = movie.averageRate
            
        } else {
            
            let movie = SearchMovies[indexPath.row]
            let url = URL(string: movie.poster_image)
            if let imageData = try? Data(contentsOf: url!, options: []) {
                cell.movieImage.image = UIImage(data: imageData)
            }
            cell.movieTitleLabel.text = movie.title_ko
            cell.ratingLabel.text = "0.0" //movie.
            
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField.isEqual(self.searchTextField)){ //titleField에서 리턴키를 눌렀다면
            
            print("\n---------- [ Search ] ----------\n")
            
            guard let token = strToken, let searchWord = searchTextField.text else { return false }
            
            let headerToken = "token " + token
            let url = "https://justdo2t.com/api/movie/search/?movie=\(searchWord)"
            
            print("\n---------- [ header ] ----------\n")
            print(headerToken)
            
            let userToken: HTTPHeaders = ["Authorization": headerToken]
            
            Alamofire.request(url, method: .get, headers: userToken)
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
                        self.HometableView.reloadData()
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
