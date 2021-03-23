//
//  UserModel.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/23.
//

import Foundation

/**
 User Model
 
 DATA
 - User ( signing Data + Auth Data )
 - Profile
 - Relevant Users Data ( single pointer )

 REQUIREMENTS
 
 - Only School Names can be translated from App
    
 */

struct UserModel: Codable, Equatable {
    
    /// User Relevant
    let uid: IDKey
    let email: String
    let password: String
    let phone: String
    /// Auth Relevant
    let school: String
    let schoolTranslations: [String: String?]
    let authHistory: [String]
    
    typealias IDKey = Int
}


// MARK: - Profile Model
extension UserModel {
    
    struct Profile: Codable, Equatable {
        /// Profile Relevant
        let name: String
        let profileImage: URL?
    }
}
// MARK: - Relationship Model
extension UserModel {
    
    struct Relationship: Codable, Equatable {
        
        let likes: [UserModel]
        let hates: [UserModel]
    }
}

// MARK: - Helpers
extension UserModel: Identifiable {
    var id: Int { uid }
}

extension UserModel {
    func school(locale: Locale) -> String {
        let localeId = locale.identifier
        if let trans = schoolTranslations[localeId], let translated = trans {
            return translated
        }
        return school
    }
}
