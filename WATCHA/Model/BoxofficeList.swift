//
//  BoxofficeList.swift
//  WATCHA
//
//  Created by Himchan Park on 2018. 4. 25..
//  Copyright © 2018년 Seo Jaehyeong. All rights reserved.
//

import Foundation



struct BoxofficeMovies: Decodable {
    var count: Int
    var next: String?
    var previous: String?
    var results: [BoxofficeMovie]
}

struct BoxofficeMovie: Decodable {

    //영화 ID
    var id: Int
    //영화 제목
    var title: String
    // 예매율
    var ticketingRate: String

    //영화 평균 별점
    var averageRate: String

    //영화 포스터 이미지 링크
    var posterImage: String
    var posterImageX3: String

    // 감독, 주연, 조연
    var members: [Members]



    private enum CodingKeys: String, CodingKey {
        case title = "title_ko"
        case ticketingRate = "ticketing_rate"
        case posterImage = "poster_image_m"
        case posterImageX3 = "poster_image_box_x3"
        case averageRate = "rating_avg"
        case id, members
    }
}

struct Members: Decodable {
    // 감독, 주연, 조연
    var type: String

    // 멤버
    var member: Int

    // 이름
    var name: String
    
    var realName: String
    
    private enum CodingKeys: String, CodingKey {
        case type, member, name
        case realName = "real_name"
    }
}



