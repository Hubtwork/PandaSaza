//
//  User.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/24.
//

import Foundation

struct UserProfile: Hashable, Codable {
    var id = UUID()
    
    let uId: Int
    /// 이름
    let userName: String
    /// 대학교
    let userSchool: String
    /// 프로필 아이콘 url
    let userProfileIcon: String
    
    /// 국적
    let userLocale: String
    /// 평점
    let userRating: Double
    /// 인증 정보들
    let userAuthMethods: [String]
    let userAuthHistory: [String]
    /// Recent Login At
    let userLoginRecent: String
    
    /// Selling Item :: Item Id 집합으로
    let sellItems: [Int]
    /// 받은 평가 - 최근 3개 정도 보여주면 될듯
    let rateHistory: [Int]
    /// 받은 리뷰 - 최근 3개 정도 보여주면 될듯
    let reviewHistory: [Int]
    
    enum CodingKeys: String, CodingKey {
        case uId
        case userName
        case userSchool
        case userProfileIcon
        
        case userLocale
        case userRating
        case userAuthMethods
        case userAuthHistory
        case userLoginRecent
        
        case sellItems
        case rateHistory
        case reviewHistory
    }
}
