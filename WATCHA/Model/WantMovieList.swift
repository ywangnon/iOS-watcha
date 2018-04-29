//
//  WantMovieList.swift
//  WATCHA
//
//  Created by Seo JaeHyeong on 24/04/2018.
//  Copyright © 2018 Seo Jaehyeong. All rights reserved.
//

import Foundation

struct WantMovieList: Codable {
   //영화 리스트 갯수
   var count: Int
   //다음 페이지 링크 url
   var next: String?
   //이전 페이지 링크 url
   var previous: String?
   //영화 정보 리스트
   var results: [WantMovie]
}


struct WantMovie: Codable{
   
   //영화 id
   var id: Int
   var title: String
   var titleEnglish: String
   //영화 평균 별점
   var averageRate: String
   var nation: String
   //영화 포스터 이미지 링크 - 앱
   var posterImage: String
   var poseterImageWeb: String
   //영화 카테고리(장르)
   var genre: [Genre]
   var runningTime: Int
   var loginUser: LoginUser
   
   
   private enum CodingKeys: String, CodingKey {
      case id
      case title = "title_ko"
      case titleEnglish = "title_en"
      case averageRate = "rating_avg"
      case nation
      case posterImage = "poster_image_my_x3"
      case poseterImageWeb = "poster_image_m"
      case genre
      case runningTime = "running_time"
      case loginUser = "login_user_checked"
   }
}


struct LoginUser: Codable {
   var id: Int
   var userWantMovie: Bool
   var userWatchedMovie: Bool
   var rating: String
   var comment: String
   var user: Int
   var movie: Int
   
   private enum CodingKeys: String, CodingKey {
      case id
      case userWantMovie = "user_want_movie"
      case userWatchedMovie = "user_watched_movie"
      case rating, comment, user, movie
   }
}












