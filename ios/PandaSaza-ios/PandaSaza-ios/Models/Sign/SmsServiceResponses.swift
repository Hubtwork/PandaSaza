//
//  SmsServiceResponses.swift
//  PandaSaza-ios
//
//  Created by 허재 on 2021/05/27.
//


struct JsonSMSValidation: Codable, Equatable {
    let isSuccess: Bool
    let validationCode: String
}

struct JsonSMSVerification: Codable, Equatable {
    let phone: String
    let registered: Bool
}
