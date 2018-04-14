//
//  User.swift
//  WATCHA
//
//  Created by Seo JaeHyeong on 09/04/2018.
//  Copyright © 2018 Seo Jaehyeong. All rights reserved.
//

import Foundation

var user_Token: String?

struct user: Decodable {
    var pk: String
    var email: String
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
