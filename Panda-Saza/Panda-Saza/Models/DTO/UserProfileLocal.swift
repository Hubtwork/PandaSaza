//
//  UserDetailLocal.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/01.
//

import Foundation

struct UserProfileLocal: Codable {
    var userProfile: UserProfile
    
    enum CodingKeys: String, CodingKey {
        case userProfile = "userProfile"
    }
}
