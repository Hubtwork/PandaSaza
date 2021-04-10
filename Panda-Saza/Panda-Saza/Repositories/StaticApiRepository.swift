//
//  StaticApiREpository.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/10.
//

import Combine
import Foundation

protocol StaticApiRepository: ApiRepository {
    
    func getSchools() -> AnyPublisher<[Schools], Error>
    
}

struct PandasazaStaticApiRepository: StaticApiRepository {
    let session: URLSession
    let baseURL: String
    
    let backgroundQueue = DispatchQueue(label: "bg_parse_queue")
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    
    func getSchools() -> AnyPublisher<[Schools], Error> {
        return request(endpoint: API.schools)
    }
    
}

// MARK: - Endpoints

extension PandasazaStaticApiRepository {
    enum API {
        case schools
    }
}

extension PandasazaStaticApiRepository.API: ApiRequest {
    
    var path: String {
        switch self {
        case .schools: return "/schools"
        }
    }
    
    var method: String {
        switch self {
        default: return "GET"
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
