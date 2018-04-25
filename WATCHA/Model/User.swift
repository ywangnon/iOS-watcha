//
//  User.swift
//  WATCHA
//
//  Created by Seo JaeHyeong on 09/04/2018.
//  Copyright © 2018 Yoo Hansub. All rights reserved.
//

import Foundation

//var user_Token: String?

struct user: Decodable {
    var pk: Int
    var email: String?
    var nickname: String
    var imgProfile: String?
    var firstName: String
    var lastName: String
    
    private enum CodingKeys: String, CodingKey {
        case imgProfile = "img_profile"
        case firstName = "first_name"
        case lastName = "last_name"
        case pk, email, nickname
    }
}

struct login_User: Decodable {
    var token: String
    var user: user
}


struct MyPage: Codable {
   var pk: Int
   var email: String
   var nickName: String
   var profileImage: String?
   var totalRunnigTime: Int
   var checkedMovieCount: Int
   var stillImage: StillImage
   
   private enum CodingKeys: String, CodingKey {
      case pk, email
      case nickName = "nickname"
      case profileImage = "img_profile"
      case totalRunnigTime = "total_running_time"
      case checkedMovieCount = "interesting_movie_cnt"
      case stillImage = "still_cut_img"
   }
}


struct StillImage: Codable {
   var id: Int
   var movieId: Int
   var imageUrl: String
   var imageUrlWeb: String
   
   private enum CodingKeys: String, CodingKey {
      case id
      case movieId = "movie"
      case imageUrl = "still_img_x3"
      case imageUrlWeb = "still_img"
   }
}












