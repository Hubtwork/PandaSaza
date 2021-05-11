//
//  SignApiRepository.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/02.
//

import Combine
import Foundation

protocol SignApiRepository: ApiRepository {
    
    func register(registration: RegistrationModel) -> AnyPublisher<DataResponse<LoginModel>, Error>
    
    func login(phone: String) -> AnyPublisher<DataResponse<LoginModel>, Error>
    func logout(phone: String) -> AnyPublisher<MsgResponse, Error>
    
    func refreshToken(refreshToken: String) -> AnyPublisher<TokenResponse, Error>
    
}

struct PandasazaSignApiRepository: SignApiRepository {
    
    let session: URLSession
    let baseURL: String
    
    let backgroundQueue = DispatchQueue(label: "bg_parse_queue")
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func register(registration: RegistrationModel) -> AnyPublisher<DataResponse<LoginModel>, Error> {
        let loginParams = [
            "phone": registration.phone,
            "profileName": registration.profileName,
            "profileImg": registration.profileImg,
            "nationality": registration.nationality,
            "school": registration.school
        ]
        return request(endpoint: API.register, params: loginParams)
    }
    
    func login(phone: String) -> AnyPublisher<DataResponse<LoginModel>, Error> {
        return request(endpoint: API.login(phone))
    }
    
    func logout(phone: String) -> AnyPublisher<MsgResponse, Error> {
        let logoutParams = ["phone": phone]
        return request(endpoint: API.logout, params: logoutParams)
    }
    
    func refreshToken(refreshToken: String) -> AnyPublisher<TokenResponse, Error> {
        let tokenParam = [ "refreshToken": refreshToken ]
        return request(endpoint: API.refreshToken, params: tokenParam)
    }
}

// MARK: - Endpoints

extension PandasazaSignApiRepository {
    enum API {
        case register
        case login(String)
        case logout
        case refreshToken
    }
}

extension PandasazaSignApiRepository.API: ApiRequest {
    
    var path: String {
        switch self {
        case .register:
            return "/register"
        case let .login(phone):
            return "/login/\(phone)"
        case .logout:
            return "/logout"
        case .refreshToken:
            return "/refresh"
        }
    }
    
    var method: String {
        switch self {
        case .login:
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
