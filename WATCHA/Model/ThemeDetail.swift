//
//  ThemeDetail.swift
//  WATCHA
//
//  Created by Himchan Park on 2018. 4. 25..
//  Copyright © 2018년 Seo Jaehyeong. All rights reserved.
//

import Foundation

struct ThemeDetailList {
    var poster: String
    var title: String
    var averageRate: String
    var ticketingRate: String
    var director: String
    var actors: String
}



let movie1 = ThemeDetailList(poster: "movie1Poster", title: "어벤져스: 인피니티 워", averageRate: "4.4", ticketingRate: "96%", director: "루소 형제", actors: "로버트 다우니 주니어, 조쉬 브롤린, 스칼렛 요한슨")

let movie2 = ThemeDetailList(poster: "movie2Poster", title: "그날 바다", averageRate: "4.9", ticketingRate: "0.4%", director: "김지영", actors: "정우성")

let movie3 = ThemeDetailList(poster: "movie3Poster", title: "램페이지", averageRate: "3.1", ticketingRate: "0.19%", director: "브레드 페이튼", actors: "드웨인 존슨, 나오미 헤리스")

let movie4 = ThemeDetailList(poster: "movie4Poster", title: "콰이어트 플레이스", averageRate: "3.5", ticketingRate: "0.17%", director: "존 크래진스키", actors: "에밀리 블런튼, 존 크래진스키")

let movie5 = ThemeDetailList(poster: "movie5Poster", title: "얼리맨", averageRate: "3.1", ticketingRate: "0.05", director: "닉 파크", actors: "에디 레드메인, 톰 히들스턴")

let movies = [movie1, movie2, movie3, movie4, movie5]
