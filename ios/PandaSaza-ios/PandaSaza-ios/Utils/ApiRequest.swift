//
//  ApiRequest.swift
//  PandaSaza-ios
//
//  Created by 허재 on 2021/05/25.
//

import Foundation
import Alamofire

protocol ApiRequest {
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    func body(params: [String: Any]) throws -> Data?
}

enum ApiError: Swift.Error {
    case invalidURL
    case invalidMethod(String)
    case httpStatusCode(HttpStatusCode)
    case unexpectedResponse
    case imageProcessing([URLRequest])
}

extension ApiError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case let .invalidMethod(method): return "Invalid Http Method: \(method)"
        case let .httpStatusCode(code): return "Unexpected HTTP Status Code: \(code)"
        case .unexpectedResponse: return "Unexpected response from the server"
        case .imageProcessing: return "Unable to load image"
        }
    }
}

extension ApiRequest {
    func urlRequest(baseURL: String, params: [String : Any]) throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw ApiError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = try body(params: params)
        return request
    }
    
    func multipartFormDataRequest(baseURL: String, imageKey: String, image: Data?, params: [String : Any]) throws -> Alamofire.UploadRequest {
        guard let url = URL(string: baseURL + path) else {
            throw ApiError.invalidURL
        }
        // randomize UUID String
        let imageUUID = UUID().uuidString
        let uuidIndex: String.Index = imageUUID.index(imageUUID.startIndex, offsetBy: 8)
        let imageName = String(imageUUID[...uuidIndex])
        // http Method initialization
        var httpMethod: HTTPMethod {
            switch (method) {
            case "GET":
                return HTTPMethod.get
            case "POST":
                return HTTPMethod.post
            case "PUT":
                return HTTPMethod.put
            case "DELETE":
                return HTTPMethod.delete
            default:
                return HTTPMethod.get
            }
        }
        // construct request
        let request = AF.upload(multipartFormData: { multipartFormData in
            // Add Body Parameters on MultipartFormData
            for (key, value) in params {
                if let val = value as? String {
                    multipartFormData.append(val.data(using: .utf8)!, withName: key)
                }
                if let val = value as? Int {
                    multipartFormData.append("\(val)".data(using: .utf8)!, withName: key)
                }
            }
            
            if let imageData = image {
                multipartFormData.append(imageData, withName: imageKey, fileName: "\(imageName).png", mimeType: "image/png")
            }
        },
        to: url,
        method: httpMethod,
        headers: HTTPHeaders(headers!)
        )
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

extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}

