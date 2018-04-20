//
//  RatingModel.swift
//  WATCHA
//
//  Created by Seo JaeHyeong on 10/04/2018.
//  Copyright © 2018 Seo Jaehyeong. All rights reserved.
//

import Foundation

struct RatingMovie: Codable{
   
   //영화 제목
   var title: String
   //출시연도
   var year: String
   //영화 포스터 이미지 링크
   var posterImage: String
   //영화 평균 별점
   var averageRate: String
   //영화 id
   var pk: Int
   //영화 카테고리(장르)
   var genre: [Genre]
   //영화 태그
   var tag: [Int]
   
   
   private enum CodingKeys: String, CodingKey {
      case title = "title_ko"
      case year = "movie_created_date"
      case posterImage = "poster_image"
      case averageRate = "rating_avg"
      case pk = "id"
      case genre
      case tag
   }
   
}


//테스트 위한 카테고리 리스트 임시 작성
struct Category {
   var title: String = ""
   var name: String = ""
   var image: String = ""
   var kind: String = ""
}


struct Genre: Codable {
   var id: Int
   var name: String
   
   private enum CodingKeys: String, CodingKey {
      case id = "id"
      case name = "genre"
   }
}














