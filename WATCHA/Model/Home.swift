//
//  Home.swift
//  WATCHA
//
//  Created by Hansub Yoo on 2018. 4. 20..
//  Copyright © 2018년 Seo Jaehyeong. All rights reserved.
//

import Foundation

struct HomeMovies: Decodable {
    var count: Int
    var next: String?
    var previous: String?
    var results: [HomeMovie]
}

struct HomeMovie: Decodable {
    
    //영화 id
    var id: Int
    //영화 제목
    var title: String
    //출시연도
    var year: Int
    //영화 포스터 이미지 링크
    var posterImage: String
    var posterImageX3: String
    //영화 평균 별점
    var averageRate: String
    //영화 카테고리(장르)
    var genre: [Genre]
    //영화 태그
    // var tag: [Int]
    
    
    private enum CodingKeys: String, CodingKey {
        case title = "title_ko"
        case year = "movie_created_date"
        case posterImage = "poster_image_m"
        case posterImageX3 = "poster_image_eval_x3"
        case averageRate = "rating_avg"
        case id, genre
        // case tag
    }
}


