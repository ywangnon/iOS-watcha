//
//  Search.swift
//  WATCHA
//
//  Created by Hansub Yoo on 2018. 4. 21..
//  Copyright © 2018년 Yoo Hansub. All rights reserved.
//

import Foundation

struct SearchMovie: Decodable {
    var count: Int
    var next: String?
    var previous: String?
    var results: [movie]
    
    struct movie: Decodable {
        var id: Int
        var title_ko: String
        var title_en: String
        var movie_created_date: Int
        var poster_image: String
        var director: String
        var main_actor: String
    }
}

