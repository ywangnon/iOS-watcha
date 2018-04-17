//
//  RatingModel.swift
//  WATCHA
//
//  Created by Seo JaeHyeong on 10/04/2018.
//  Copyright © 2018 Seo Jaehyeong. All rights reserved.
//

import Foundation

struct RatingMovie: Codable{
   
   var movieTitle: String = "레디 플레이어 원"
   var movieYear: String = "2018"
   var movieImage: String = "ready_player_one"
   var movieRate: Double = 0.0
   
   var moviePk: Int = 0
   var movieCategory: String = ""
   
}


//테스트 위한 카테고리 리스트 임시 작성
struct Category {
   var title: String = ""
   var image: String = ""
   var pk: Int = 0
}














