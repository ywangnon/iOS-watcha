//
//  MovieDetail.swift
//  WATCHA
//
//  Created by Seo JaeHyeong on 16/04/2018.
//  Copyright © 2018 Seo Jaehyeong. All rights reserved.
//

import Foundation

struct MovieDetailInfo{
   
   var title: String = ""
   var year: String = ""
   var nation: String = ""
   var genre: String = ""
   var playTimg: String = ""
   var ratedPoint: String = ""
   var category: String = ""
   
   var bgImage: String = ""
   var posterImage: String = ""
   
   var story: String = ""
   
   var actors: [Actor] = []
   var gallery: [String] = []
   var youtube: [String] = []
   var comments: [Comment] = []
   var recommendMovies: [RatingMovie] = []
   
}


struct Actor {
   var name: String = ""
   var position: String = ""
   var profileImage: String = ""
}

struct Comment {
   var userName: String = ""
   var userProfile: String = ""
   var time: String = ""
   var ratedPoint: Int = 0
}














