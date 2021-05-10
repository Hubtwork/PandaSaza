//
//  JSONModels.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/13.
//

import Foundation

// MARK:- Models

struct JsonSMSValidation: Codable, Equatable {
    let isSuccess: Bool
    let validationCode: String
}

struct JsonSMSVerification: Codable, Equatable {
    
    let phone: String
    let registered: Bool
    /// IF already registered, redirect to logIn and return these
    // account ID
    let user: String?
    let tokens: Tokens?
}

struct Tokens: Codable, Equatable {
    let accessToken: String
    let refreshToken: String
}

