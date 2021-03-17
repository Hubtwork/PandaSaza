//
//  UserData.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/03.
//

import Foundation

struct UserData: Hashable, Codable {
    var id = UUID()
    
    let uId: Int
    
    let userId: String
    let userEmail: String
    /// 이름
    let userName: String
    /// 대학교
    let userSchool: String
    
    let userProfileIcon: String
    
    enum CodingKeys: String, CodingKey {
        case uId
        
        case userId
        case userEmail
        
        case userName
        case userSchool
        case userProfileIcon
    }
}
