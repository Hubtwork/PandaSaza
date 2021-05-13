//
//  SMS.swift
//  Panda-Saza
//
//  Created by 허재 on 2021/05/10.
//

import Foundation

struct JsonSMSValidation: Codable, Equatable {
    let isSuccess: Bool
    let validationCode: String
}

struct JsonSMSVerification: Codable, Equatable {
    let phone: String
    let registered: Bool
}
