//
//  ThemeDetailTableViewController.swift
//  WATCHA
//
//  Created by Himchan Park on 2018. 4. 12..
//  Copyright © 2018년 Seo Jaehyeong. All rights reserved.
//

import UIKit
import Alamofire

class ThemeDetailTableViewController: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        let numberOfRows = movies.count
        
        return numberOfRows
        
    }

    

    
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "themeDetailCell", for: indexPath) as! ThemeDetailTableViewCell
    
            let movie = movies[indexPath.row]
    
    
            cell.titleLabel?.text = movie.title
            cell.posterImage.image = UIImage(named: movie.poster)
            cell.averageRatingLabel?.text = "평균 ★ " + movie.averageRate
            cell.depositAndBoxOfficeLabel?.text = "예매율: " + movie.ticketingRate
            cell.directorLabel?.text = "감독: " + movie.director
            cell.actorsLabel?.text = "주연배우: " + movie.actors
    
    
            return cell
        }
    

}
