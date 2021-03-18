//
//  APIRequest.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/18.
//

import Foundation

protocol ApiRequest {
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    func body() throws -> Data?
}

enum ApiError: Swift.Error {
    case invalidURL
    case httpStatusCode(HttpStatusCode)
    case unexpectedResponse
    case imageProcessing([URLRequest])
}

extension ApiError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case let .httpStatusCode(code): return "Unexpected HTTP Status Code: \(code)"
        case .unexpectedResponse: return "Unexpected response from the server"
        case .imageProcessing: return "Unable to load image"
        }
    }
}

extension ApiRequest {
    func urlRequest(baseURL: String) throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw ApiError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = try body()
        return request
    }
}

typealias HttpStatusCode = Int
typealias HttpStatusCodes = Range<HttpStatusCode>

extension HttpStatusCodes {
    static let success = 200 ..< 300
    static let clientError = 400 ..< 500
    static let serverError = 500 ..< 600
}
