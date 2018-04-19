//
//  MainMovie.swift
//  WATCHA
//
//  Created by Hansub Yoo on 2018. 4. 19..
//  Copyright © 2018년 Seo Jaehyeong. All rights reserved.
//

import Foundation

struct MainMovie {
    var id: Int
    var title_ko: String
    var poster_image: String
    var rating_avg: String
    var genre: [Genre]
    var tag: [Int]
}
