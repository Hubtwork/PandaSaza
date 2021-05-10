//
//  Account.swift
//  Panda-Saza
//
//  Created by 허재 on 2021/05/10.
//

import Foundation


struct Account: Equatable, Codable {
    let accountId: String
    let phone: String
    let registeredAt: Date
    let updatedAt: Date
    
    let user: User
    
    typealias ID = String
}

extension Account: Identifiable {
    var id: ID { accountId }
}

struct User: Equatable, Codable {
    let uId: ID
    let school: String
    let nationality: String
    let registeredAt: Date
    let updatedAt: Date
    
    let profile: Profile
    
    typealias ID = Int
}

extension User: Identifiable {
    var id: ID { uId }
}

struct Profile: Equatable, Codable {
    let profileId: ID
    let profileName: String
    let profileImage: String
    
    typealias ID = Int
}

extension Profile: Identifiable {
    var id: ID { profileId }
}
