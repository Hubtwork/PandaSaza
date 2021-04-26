//
//  SignApiRepository.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/02.
//

import Combine
import Foundation

protocol SignApiRepository: ApiRepository {
    
    func signIn(id: String, password: String) -> AnyPublisher<UserModel, Error>
    
    func auth(phone: String) -> AnyPublisher<JsonSmsValidation, Error>
    
}

struct PandasazaSignApiRepository: SignApiRepository {
    let session: URLSession
    let baseURL: String
    
    let backgroundQueue = DispatchQueue(label: "bg_parse_queue")
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func signIn(id: String, password: String) -> AnyPublisher<UserModel, Error> {
        let signInParams = ["id": id, "pw": password]
        return request(endpoint: API.signIn, params: signInParams)
    }
    
    
    func auth(phone: String) -> AnyPublisher<JsonSmsValidation, Error> {
        return request(endpoint: API.authSMS(phone))
    }
    
}

// MARK: - Endpoints

extension PandasazaSignApiRepository {
    enum API {
        case signIn
        case signUp
        case authSMS(String)
    }
}

extension PandasazaSignApiRepository.API: ApiRequest {
    
    var path: String {
        switch self {
        case .signIn:
            return "/signIn"
        case .signUp:
            return "/sign/signUp"
        case let .authSMS(phone):
            return "/auth/sms/\(phone)"
        }
    }
    
    var method: String {
        switch self {
        case .authSMS:
            return "GET"
        case .signIn, .signUp:
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
