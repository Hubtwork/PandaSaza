//
//  UserDataLocal.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/03.
//

import Foundation

struct UserDataLocal: Codable {
    var userData: UserData
    
    enum CodingKeys: String, CodingKey {
        case userData = "userData"
    }
}
