//
//  BoxOfficeTableViewController.swift
//  WATCHA
//
//  Created by Seo JaeHyeong on 12/04/2018.
//  Copyright © 2018 Seo Jaehyeong. All rights reserved.
//

import UIKit
import Alamofire

class BoxOfficeTableViewController: UITableViewController {
    
    @IBOutlet var boxofficeTableView: UITableView!
    private let boxofficeTOKEN = UserDefaults.standard.string(forKey: "user_Token")
    
    var result: BoxofficeMovies!
    var movies: [BoxofficeMovie] = []
    
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
        
        guard let token = boxofficeTOKEN else { return }
        
        print("\n---------- [ header ] ----------\n")
        
        let hederToken = "token " + token
        print(hederToken)
        
        let userToken: HTTPHeaders = ["Authorization":hederToken]
        
        print("\n---------- [ url ] ----------\n")
        
        Alamofire.request(API.Movie.box_Office_Detail, method: .get, headers: userToken)
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
                    self.result = try decoder.decode(BoxofficeMovies.self, from: data)
                    self.movies = self.result.results
                    print(self.movies)
                    self.boxofficeTableView.reloadData()
                } catch {
                    print("\n---------- [ error4 ] ----------\n")
                    print(error)
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovieData()
    }

    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "boxofficeCell", for: indexPath) as! BoxofficeTableViewCell
        
        let movie = movies[indexPath.row]
        let tapImageGesture = MovieTapGesture(target: self, action: #selector(self.movieTapped))
        
        let url = URL(string: movie.posterImageX3)
        if let imageData = try? Data(contentsOf: url!, options: []) {
            cell.posterImage.image = UIImage(data: imageData)
        }
        
        cell.titleLabel.text = movie.title
        cell.averageRatingLabel.text = movie.averageRate
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
