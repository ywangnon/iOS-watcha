//
//  BoxofficeList.swift
//  WATCHA
//
//  Created by Himchan Park on 2018. 4. 25..
//  Copyright © 2018년 Seo Jaehyeong. All rights reserved.
//

import Foundation

//struct BoxofficeMovie {
//    var poster: String
//    var title: String
//    var averageRate: String
//    var ticketingRate: String
//    var director: String
//    var actors: String
//}
//
//
//
//let movie1 = BoxofficeMovie(poster: "movie1Poster", title: "어벤져스: 인피니티 워", averageRate: "4.4", ticketingRate: "96%", director: "루소 형제", actors: "로버트 다우니 주니어, 조쉬 브롤린, 스칼렛 요한슨")
//
//let movie2 = BoxofficeMovie(poster: "movie2Poster", title: "그날 바다", averageRate: "4.9", ticketingRate: "0.4%", director: "김지영", actors: "정우성")
//
//let movie3 = BoxofficeMovie(poster: "movie3Poster", title: "램페이지", averageRate: "3.1", ticketingRate: "0.19%", director: "브레드 페이튼", actors: "드웨인 존슨, 나오미 헤리스")
//
//let movie4 = BoxofficeMovie(poster: "movie4Poster", title: "콰이어트 플레이스", averageRate: "3.5", ticketingRate: "0.17%", director: "존 크래진스키", actors: "에밀리 블런튼, 존 크래진스키")
//
//let movie5 = BoxofficeMovie(poster: "movie5Poster", title: "얼리맨", averageRate: "3.1", ticketingRate: "0.05", director: "닉 파크", actors: "에디 레드메인, 톰 히들스턴")
//
//let movies = [movie1, movie2, movie3, movie4, movie5]

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


