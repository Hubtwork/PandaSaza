//
//  SmsApiRepository.swift
//  Panda-Saza
//
//  Created by 허재 on 2021/05/11.
//

// MARK:- ENDPOINT: { AUTHSERVER }/sms

import Combine
import Foundation

protocol SmsApiRepository: ApiRepository {
    
    func smsVerification(phone: String) -> AnyPublisher<DataResponse<JsonSMSVerification>, Error>
    func smsValidation(phone: String) -> AnyPublisher<DataResponse<JsonSMSValidation>, Error>
    
}

struct PandasazaSmspiRepository: SmsApiRepository {
    
    let session: URLSession
    let baseURL: String
    
    let backgroundQueue = DispatchQueue(label: "bg_parse_queue")
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func smsValidation(phone: String) -> AnyPublisher<DataResponse<JsonSMSValidation>, Error> {
        return request(endpoint: API.smsValidation(phone))
    }
    
    func smsVerification(phone: String) -> AnyPublisher<DataResponse<JsonSMSVerification>, Error> {
        return request(endpoint: API.smsVerification(phone))
    }
}

// MARK: - Endpoints

extension PandasazaSmspiRepository {
    enum API {
        case smsVerification(String)
        case smsValidation(String)
    }
}

extension PandasazaSmspiRepository.API: ApiRequest {
    
    var path: String {
        switch self {
        case let .smsVerification(phone):
            return "/authenticate/\(phone)"
        case let .smsValidation(phone):
            return "/validate/\(phone)"
        }
    }
    
    var method: String {
        switch self {
        case .smsVerification, .smsValidation:
            return "GET"
        }
    }
    
    var headers: [String: String]? {
        return ["Accept": "application/json"]
    }
    
    func body(params: [String: Any] = [:]) throws -> Data? {
        return nil
    }
}
