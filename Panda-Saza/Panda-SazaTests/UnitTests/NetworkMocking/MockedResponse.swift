//
//  MockedResponse.swift
//  Panda-SazaTests
//
//  Created by Jae Heo on 2021/03/25.
//

import Foundation
@testable import Panda_Saza

extension RequestMocking {
    struct MockedResponse {
        let url: URL
        let result: Result<Data, Swift.Error>
        let httpCode: HttpStatusCode
        let headers: [String: String]
        let loadingTime: TimeInterval
        let customResponse: URLResponse?
    }
}

extension RequestMocking.MockedResponse {
    enum Error: Swift.Error {
        case failedMockCreation
    }
    
    init<T>(apiRequest: ApiRequest, baseURL: String,
            result: Result<T, Swift.Error>,
            httpCode: HttpStatusCode = 200,
            headers: [String: String] = ["Content-Type": "application/json"],
            loadingTime: TimeInterval = 0.1
    ) throws where T: Encodable {
        guard let url = try apiRequest.urlRequest(baseURL: baseURL).url
            else { throw Error.failedMockCreation }
        self.url = url
        switch result {
        case let .success(value):
            self.result = .success(try JSONEncoder().encode(value))
        case let .failure(error):
            self.result = .failure(error)
        }
        self.httpCode = httpCode
        self.headers = headers
        self.loadingTime = loadingTime
        customResponse = nil
    }
    
    init(apiRequest: ApiRequest, baseURL: String, customResponse: URLResponse) throws {
        guard let url = try apiRequest.urlRequest(baseURL: baseURL).url
            else { throw Error.failedMockCreation }
        self.url = url
        result = .success(Data())
        httpCode = 200
        headers = [String: String]()
        loadingTime = 0
        self.customResponse = customResponse
    }
    
    init(url: URL, result: Result<Data, Swift.Error>) {
        self.url = url
        self.result = result
        httpCode = 200
        headers = [String: String]()
        loadingTime = 0
        customResponse = nil
    }
}
