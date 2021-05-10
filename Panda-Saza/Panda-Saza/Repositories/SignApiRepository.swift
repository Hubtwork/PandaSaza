//
//  SignApiRepository.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/02.
//

import Combine
import Foundation

protocol SignApiRepository: ApiRepository {
    
    func smsVerification(phone: String) -> AnyPublisher<JsonSMSVerification, Error>
    func smsValidation(phone: String) -> AnyPublisher<JsonSMSValidation, Error>
    
    func logout(phone: String) -> AnyPublisher<MsgResponse, Error>
    
}

struct PandasazaSignApiRepository: SignApiRepository {
    
    let session: URLSession
    let baseURL: String
    
    let backgroundQueue = DispatchQueue(label: "bg_parse_queue")
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    func logout(phone: String) -> AnyPublisher<MsgResponse, Error> {
        let logoutParams = ["phone": phone]
        return request(endpoint: API.logout, params: logoutParams)
    }
    
    func smsValidation(phone: String) -> AnyPublisher<JsonSMSValidation, Error> {
        return request(endpoint: API.smsVerification(phone))
    }
    
    func smsVerification(phone: String) -> AnyPublisher<JsonSMSVerification, Error> {
        return request(endpoint: API.smsValidation(phone))
    }
}

// MARK: - Endpoints

extension PandasazaSignApiRepository {
    enum API {
        case register
        case logout
        case refreshToken
        case smsVerification(String)
        case smsValidation(String)
    }
}

extension PandasazaSignApiRepository.API: ApiRequest {
    
    var path: String {
        switch self {
        case .register:
            return "/register"
        case .logout:
            return "/logout"
        case .refreshToken:
            return "/refresh"
        case let .smsVerification(phone):
            return "/sms/authenticate/\(phone)"
        case let .smsValidation(phone):
            return "/sms/validation/\(phone)"
        }
    }
    
    var method: String {
        switch self {
        case .smsVerification, .smsValidation:
            return "GET"
        case .register, .logout, .refreshToken:
            return "POST"
        }
    }
    
    var headers: [String: String]? {
        return ["Accept": "application/json"]
    }
    
    func body(params: [String: Any] = [:]) throws -> Data? {
        if params.isEmpty { return nil }
        return params
            .map{ $0.key + "=" + "\($0.value)" }
            .joined(separator: "&")
            .data(using: .utf8)
    }
}
