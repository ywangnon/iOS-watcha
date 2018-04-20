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
        static let emailSignUp = API.baseURL + "api/members/signup/"
        static let emailSignIn = API.baseURL + "api/members/email-auth-token/"
        static let facebookSignIn = API.baseURL + "api/members/facebook-auth-token/"
    }
    enum Post {
        static let list = API.baseURL + "api/members/"
    }
   enum Movie {
      static let detail = API.baseURL + "api/movie/"
      static let memberDetail = API.baseURL + "api/movie-members/"
   }
}
