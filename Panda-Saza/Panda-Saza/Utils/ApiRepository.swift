//
//  ApiRepository.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/18.
//

import Foundation
import Combine

protocol ApiRepository {
    var session: URLSession { get }
    var baseURL: String { get }
    var backgroundQueue: DispatchQueue { get }
}

// MARK: - Http Request Implementation

extension ApiRepository {
    func request<Value>(endpoint: ApiRequest, httpStatusCodes: HttpStatusCodes = .success, params: [String: Any] = [:]) -> AnyPublisher<Value, Error>
        where Value: Decodable {
        do {
            let request = try endpoint.urlRequest(baseURL: baseURL, params: params)
            print("URL Request: [\(String(describing: request.httpMethod))] \(String(describing: request.url))")
            print("Params : \(params)")
            return session
                .dataTaskPublisher(for: request)
                .requestJSON(httpStatusCodes: httpStatusCodes)
                .ensureTimeSpan(0.5)
        } catch let error {
            return Fail<Value, Error>(error: error).eraseToAnyPublisher()
        }
    }
    
    func postRequest<Value>(endpoint: ApiRequest, params: [String: Any], httpStatusCodes: HttpStatusCodes = .success) -> AnyPublisher<Value, Error>
        where Value: Decodable {
        do {
            let request = try endpoint.postRequest(baseURL: baseURL, params: params)
            print("URL Request: [\(String(describing: request.httpMethod))] \(String(describing: request.url))")
            print("Params : \(params)")
            return session
                .dataTaskPublisher(for: request)
                .requestJSON(httpStatusCodes: httpStatusCodes)
                .ensureTimeSpan(0.5)
        } catch let error {
            return Fail<Value, Error>(error: error).eraseToAnyPublisher()
        }
    }
}

// MARK: - JSON Request Optimize Helper

private extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func requestJSON<Value>(httpStatusCodes: HttpStatusCodes) -> AnyPublisher<Value, Error> where Value: Decodable {
        return tryMap {
                assert(!Thread.isMainThread)
                guard let code = ($0.1 as? HTTPURLResponse)?.statusCode else {
                    throw ApiError.unexpectedResponse
                }
                guard httpStatusCodes.contains(code) else {
                    throw ApiError.httpStatusCode(code)
                }
                return $0.0
            }
            .extractUnderlyingError()
            .decode(type: Value.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

