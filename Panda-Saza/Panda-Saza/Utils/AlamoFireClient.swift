//
//  AlamoFireClient.swift
//  Panda-Saza
//
//  Created by 허재 on 2021/05/16.
//

import Foundation
import Combine
import Alamofire


enum AFResponseError: Error {
    case http(ErrorData)
    case unknown
}
     
struct ErrorData: Codable {
    var statusCode: Int
    var message: String
    var error: String?
}

struct AFClient {
    
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    func httpRequest<T: Decodable>(_ request: DataRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, AFResponseError> {
        return request.validate()
            .publishData(emptyResponseCodes: [200, 204, 205])
            .tryMap { result -> Response<T> in
                // Error Handling
                if let error = result.error {
                    if let errorData = result.data {
                        let value = try decoder.decode(ErrorData.self, from: errorData)
                        throw AFResponseError.http(value)
                    } else {
                        throw error
                    }
                }
                // successful Response & Result has data
                if let data = result.data {
                    let value = try decoder.decode(T.self, from: data)
                    return Response(value: value, response: result.response!)
                } else {
                // successful Response & no data
                    return Response(value: Empty.emptyValue() as! T, response: result.response!)
                }
            }
            .mapError({ (error) -> AFResponseError in
                if let apiError = error as? AFResponseError {
                    return apiError
                } else {
                    return .unknown
                }
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

struct ImageUploadClient {
    
    static let client = AFClient()
    
    
    
}
