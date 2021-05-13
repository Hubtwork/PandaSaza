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
    
    func verifyingSMS(phone: String) -> AnyPublisher<Bool, Error>
    func requestSMSValidation(phone: String) -> AnyPublisher<String, Error>
}

struct PandasazaSmsApiRepository: SmsApiRepository {
    
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
    
    func verifyingSMS(phone: String) -> AnyPublisher<Bool, Error> {
        let smsRequest: AnyPublisher<DataResponse<JsonSMSVerification>, Error> = request(endpoint: API.smsVerification(phone))
        return smsRequest.map { return $0.data.registered }.eraseToAnyPublisher()
    }
    
    func requestSMSValidation(phone: String) -> AnyPublisher<String, Error> {
        let smsRequest: AnyPublisher<DataResponse<JsonSMSValidation>, Error> = request(endpoint: API.smsValidation(phone))
        return smsRequest.map { return $0.data.validationCode }.eraseToAnyPublisher()
    }
}

// MARK: - Endpoints

extension PandasazaSmsApiRepository {
    enum API {
        case smsVerification(String)
        case smsValidation(String)
    }
}

extension PandasazaSmsApiRepository.API: ApiRequest {
    
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
