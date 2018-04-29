//
//  MovieDetail.swift
//  WATCHA
//
//  Created by Seo JaeHyeong on 16/04/2018.
//  Copyright © 2018 Seo Jaehyeong. All rights reserved.
//

import Foundation

struct MovieDetailInfo: Codable{
   //영화 고유 아이디
   var id: Int
   //영화 제목 : 한국어
   var titleKorean: String
   //영화 제목 : 영어
   var titleEnglish: String
   //개봉일시
   var year: String
   //영화 등급
   var filmRate: String
   //영화 시간
   var playTime: Int
   //영화 줄거리
   var story: String
   //국가
   var nation: String
   //예매율
   var ticketingRate: String?
   //관객수
   var audience: Int
   //평균별점
   var averageRating: String
   //영화 평가 정보
   var movieInfo: MovieEvaluationInfo
   //그래프를 위한 각 등급별 수치 예)1.0:100, 2.0:200 ...
   //var movieRatingData: [[String: Int]]?
   var movieRatingData: [String: Int]?
   //포스터이미지 - 웹용
   var posterImageWeb: String
   //포스터이미지 - 앱용
   //var posterImage: String
   //스틸컷
   var stillCuts: [StillCut]?
   //장르 - 모험, 드라마, 판타지
   var genre: [Genre]?
   //태그 - 소설원작, 몽환적인, 화려한
   var tag: [Tag]?
   //유튜브 링크
   var youtubeUrls: [Youtube]?
   //출연배우
   var actors: [ActorType]
   //영화 코멘트 리스트
   var comments: [Comment]?
   
   private enum CodingKeys: String, CodingKey {
      case id
      case titleKorean = "title_ko"
      case titleEnglish = "title_en"
      case year = "d_day"
      case filmRate = "film_rate"
      case playTime = "running_time"
      case story = "intro"
      case nation = "nation"
      case ticketingRate = "ticketing_rate"
      case audience = "audience"
      case averageRating = "rating_avg"
      case movieInfo = "movie_eval_info"
      case movieRatingData = "movie_rating_data"
      case posterImageWeb = "poster_image_m"
      //case posterImage = "poster_image_my_x3"
      case stillCuts = "still_cuts"
      case genre
      case tag
      case youtubeUrls = "trailer_youtube"
      case actors = "movie_member_list"
      case comments = "movie_checking_data"
   }
   
}



struct MovieEvaluationInfo: Codable {
   var ratingCount: Int
   var wantCheckedCount: Int
   var commentCount: Int
   
   private enum CodingKeys: String, CodingKey {
      case ratingCount = "rating_cnt"
      case wantCheckedCount = "want_movie_cnt"
      case commentCount = "comment_cnt"
   }
}


struct StillCut: Codable {
   var id: Int
   var movieId: Int
   var imageWeb: String
   var image: String
   
   private enum CodingKeys: String, CodingKey {
      case id
      case movieId = "movie"
      case imageWeb = "still_img"
      case image = "still_img_x3"
   }
}


struct Tag: Codable {
   var id: Int
   var tag: String
}


struct Youtube: Codable {
   var title: String
   var urlThumbNail: String
   var url: String
   
   private enum CodingKeys: String, CodingKey {
      case title
      case urlThumbNail = "url_thumbnail"
      case url = "get_trailer_url"
   }
}


struct ActorType: Codable {
   var movieId: Int
   var actor: Actor
   var type: String
   var position: String?
   
   private enum CodingKeys: String, CodingKey {
      case movieId = "movie"
      case actor = "member"
      case type
      case position = "role_name"
   }
}


struct Actor: Codable {
   var id: Int
   var name: String
   var profileImageWeb: String
   var profileImage: String
   
   
   private enum CodingKeys: String, CodingKey {
      case id
      case name
      case profileImageWeb = "img_profile"
      case profileImage = "img_profile_x3"
   }
}


struct Comment: Codable {
   var id: Int
   var checkedWant: Bool
   var checkedWatch: Bool
   var rating: String
   var comment: String
   var updatedDate: String
   var user: CommentUser
   var movieId: Int
   
   private enum CodingKeys: String, CodingKey {
      case id
      case checkedWant = "user_want_movie"
      case checkedWatch = "user_watched_movie"
      case rating
      case comment
      case updatedDate = "modified_date"
      case user
      case movieId = "movie"
   }
}


struct CommentUser: Codable {
   var pk: Int
   var email: String
   var nickName: String
   var profileImage: String?
   
   private enum CodingKeys: String, CodingKey {
      case pk
      case email
      case nickName = "nickname"
      case profileImage = "img_profile"
   }
}















