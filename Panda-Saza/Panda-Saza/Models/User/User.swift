//
//  User.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/24.
//

import Foundation

struct User: Hashable, Codable {
    var uid: Int
    
    var userId: String
    var userPw: String
    
    var userName: String
}

