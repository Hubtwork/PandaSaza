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
    
}

// MARK: - Endpoints

extension PandasazaSignApiRepository {
    enum API {
        case signIn
        case signUp
    }
}

extension PandasazaSignApiRepository.API: ApiRequest {
    
    var path: String {
        switch self {
        case .signIn:
            return "/signIn"
        case .signUp:
            return "/sign/signUp"
        }
    }
    
    var method: String {
        switch self {
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
