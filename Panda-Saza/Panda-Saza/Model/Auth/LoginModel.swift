//
//  LoginModel.swift
//  Panda-Saza
//
//  Created by 허재 on 2021/05/11.
//

import Foundation

struct LoginModel: Codable, Equatable {
    let phone: String
    let accountId: String
    let tokens: Tokens
}
