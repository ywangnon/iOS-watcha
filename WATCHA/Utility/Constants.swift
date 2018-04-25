//
//  Constants.swift
//  WATCHA
//
//  Created by Hansub Yoo on 2018. 4. 9..
//  Copyright © 2018년 Yoo Hansub. All rights reserved.
//

import Foundation

enum API {
   static let baseURL = "https://justdo2t.com/"
   
   enum Auth {
      static let signUp = API.baseURL + "api/members/signup/"
      static let emailLogin = API.baseURL + "api/members/email-auth-token/"
      static let facebookLogin = API.baseURL + "api/members/facebook-auth-token/"
      static let logout = API.baseURL + "api/members/logout/"
   }
   
   enum User {
      static let list = API.baseURL + "api/members/"
      static let detail = API.baseURL + "api/members/detail/"
      static let update = API.baseURL + "api/members/detail/"
      static let delete = API.baseURL + "api/members/detail/"
      static let img_Profile_Update = API.baseURL + "api/members/{pk값}/img-profile/"
      static let logout = API.baseURL + "api/members/logout/"
   }
   
   enum Movie {
      static let box_Office_List = API.baseURL + "api/movie/box-office/name-list/"
      static let box_Office_Top5 = API.baseURL + "api/movie/box-office/five-list/"
      static let box_Office_Detail = API.baseURL + "api/movie/box-office/"
      
      static let detail = API.baseURL + "api/movie/"
      static let memberDetail = API.baseURL + "api/movie-members/"
   }
   
   enum MainPage {
      
      static let Box_office = API.baseURL + "api/movie/box-office/name-list/"
      static let Top5Movie = API.baseURL + "api/movie/box-office/five-list/"
      
      enum sortByTag {
         static let topKorea = API.baseURL + "api/movie/tag/top-korea/"
         static let millionSeller = API.baseURL + "api/movie/tag/million-seller/"
         static let topWorld = API.baseURL + "api/movie/tag/top-world/"
         static let hero = API.baseURL + "api/movie/tag/hero/"
         static let sports = API.baseURL + "api/movie/tag/sports/"
         static let family = API.baseURL + "api/movie/tag/family/"
      }
      enum sortByGenre {
         static let action = API.baseURL + "api/movie/genre/action/"
         static let crime = API.baseURL + "api/movie/genre/crime/"
         static let drama = API.baseURL + "api/movie/genre/drama/"
         static let comedy = API.baseURL + "api/movie/genre/comedy/"
         static let romance = API.baseURL + "api/movie/genre/romance/"
         static let thriller = API.baseURL + "api/movie/genre/thriller/"
         static let roco = API.baseURL + "api/movie/genre/roco/"
         static let war = API.baseURL + "api/movie/genre/war/"
         static let fantasy = API.baseURL + "api/movie/genre/fantasy/"
         static let sf = API.baseURL + "api/movie/genre/sf/"
         static let animation = API.baseURL + "api/movie/genre/animation/"
         static let documentary = API.baseURL + "api/movie/genre/documentary/"
         static let horror = API.baseURL + "api/movie/genre/horror/"
         static let western = API.baseURL + "api/movie/genre/western/"
         static let musical = API.baseURL + "api/movie/genre/musical/"
         static let martialArts = API.baseURL + "api/movie/genre/martial-arts/"
         static let mistery = API.baseURL + "api/movie/genre/mistery/"
         static let cult = API.baseURL + "api/movie/genre/cult/"
         
         /********************************************
          액션 = action
          범죄 = crime
          드라마 = drama
          코미디 = comedy
          로맨스/멜로 = romance
          스릴러 = thriller
          로맨틱코미디 = roco
          전쟁 = war
          판타지 = fantasy
          SF = sf
          애니메이션 = animation
          다큐멘터리 = documentary
          공포 = horror
          서부 = western
          뮤지컬 = musical
          무협 = martial-arts
          미스터리 = mistery
          컬트 = cult
          ********************************************/
      }
   }
   
   enum  EvalPage {
      static let ratingTop = API.baseURL + "api/movie/eval/rating-top/"
      
      enum sortByTag {
         static let topKorea = API.baseURL + "api/movie/eval/tag/top-korea/"
         static let millionSeller = API.baseURL + "api/movie/eval/tag/million-seller/"
         static let topWorld = API.baseURL + "api/movie/eval/tag/top-world/"
         static let hero = API.baseURL + "api/movie/eval/tag/hero/"
         static let sports = API.baseURL + "api/movie/eval/tag/sports/"
         static let family = API.baseURL + "api/movie/eval/tag/family/"
         
      }
      
      enum sortByGenre {
         static let action = API.baseURL + "api/movie/eval/genre/action/"
         static let crime = API.baseURL + "api/movie/eval/genre/crime/"
         static let drama = API.baseURL + "api/movie/eval/genre/drama/"
         static let comedy = API.baseURL + "api/movie/eval/genre/comedy/"
         static let romance = API.baseURL + "api/movie/eval/genre/romance/"
         static let thriller = API.baseURL + "api/movie/eval/genre/thriller/"
         static let roco = API.baseURL + "api/movie/eval/genre/roco/"
         static let war = API.baseURL + "api/movie/eval/genre/war/"
         static let fantasy = API.baseURL + "api/movie/eval/genre/fantasy/"
         static let sf = API.baseURL + "api/movie/eval/genre/sf/"
         static let animation = API.baseURL + "api/movie/eval/genre/animation/"
         static let documentary = API.baseURL + "api/movie/eval/genre/documentary/"
         static let horror = API.baseURL + "api/movie/eval/genre/horror/"
         static let western = API.baseURL + "api/movie/eval/genre/western/"
         static let musical = API.baseURL + "api/movie/eval/genre/musical/"
         static let martialArts = API.baseURL + "api/movie/eval/genre/martial-arts/"
         static let mistery = API.baseURL + "api/movie/eval/genre/mistery/"
         static let cult = API.baseURL + "api/movie/eval/genre/cult/"
         
         /********************************************
          액션 = action
          범죄 = crime
          드라마 = drama
          코미디 = comedy
          로맨스/멜로 = romance
          스릴러 = thriller
          로맨틱코미디 = roco
          전쟁 = war
          판타지 = fantasy
          SF = sf
          애니메이션 = animation
          다큐멘터리 = documentary
          공포 = horror
          서부 = western
          뮤지컬 = musical
          무협 = martial-arts
          미스터리 = mistery
          컬트 = cult
          ********************************************/
      }
   }
   
   enum MovieDetail {
      
   }
   
   enum MyPage {
      static let checkList = API.baseURL + "api/movie/user-checked-movie/?pk="
      static let checkCreate = API.baseURL + "api/movie/user-checked-movie/create/"
      static let checkUpdate = API.baseURL + "api/movie/user-checked-movie/"
   }
}
