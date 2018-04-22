//
//  Constants.swift
//  WATCHA
//
//  Created by Hansub Yoo on 2018. 4. 9..
//  Copyright © 2018년 Seo Jaehyeong. All rights reserved.
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
        static let detail = API.baseURL + "api/members/detail"
        static let update = API.baseURL + "api/members/detail/"
        static let delete = API.baseURL + "api/members/detail/"
        static let img_Profile_Update = API.baseURL + "api/members/{pk값}/img-profile/"
    }
    
    enum Movie {
        static let box_Office_List = API.baseURL + "api/movie/box-office/name-list/"
        static let box_Office_Top5 = API.baseURL + "api/movie/box-office/five-list/"
        static let box_Office_Detail = API.baseURL + "api/movie/box-office/"
      
        static let detail = API.baseURL + "api/movie/"
        static let memberDetail = API.baseURL + "api/movie-members/"
    }
    
    enum MainPage {
        static let sortByTag = API.baseURL + "api/movie/tag/<#태그명#>/"
        static let sortByGenre = API.baseURL + "api/movie/genre/<#장르명#>/"
    }
    
    enum  EvalPage {
        static let ratingTop = API.baseURL + "api/movie/eval/rating-top/"
        static let sortByTag = API.baseURL + "api/movie/eval/tag/<#태그명#>/"
        static let sortByGenre = API.baseURL + "api/movie/eval/genre/<#장르명#>/"
    }
    
    enum MovieDetail {
        
    }
   
}
