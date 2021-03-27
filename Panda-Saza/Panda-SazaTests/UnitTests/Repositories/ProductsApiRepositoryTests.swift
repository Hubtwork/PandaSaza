//
//  ProductsApiRepositoryTests.swift
//  Panda-SazaTests
//
//  Created by Jae Heo on 2021/03/25.
//

import XCTest
import Combine
@testable import Panda_Saza

class ProductsApiRepositoryTests: XCTestCase {
    
    private var sut: PandasazaProductsApiRepository!
    private var subscriptions = Set<AnyCancellable>()
    
    typealias API = PandasazaProductsApiRepository.API
    typealias Mock = RequestMocking.MockedResponse
    
    override func setUp() {
        subscriptions = Set<AnyCancellable>()
        sut = PandasazaProductsApiRepository(session: .mockedResponsesOnly,
                                             baseURL: "http://localhost:3000/product")
    }
    
    override func tearDown() {
        // TearDown Contents
        RequestMocking.removeAllMocks()
    }
    
    func test_testServerProductList() throws {
        let exp = XCTestExpectation(description: "Completion")
        sut.loadProducts().sinkToResult { result in
            print(result)
            exp.fulfill()
        }.store(in: &subscriptions)
        wait(for: [exp], timeout: 2)
    }
    
    func test_productList() throws {
        let response = Product.mockedData
        try mock(.productList, result: .success(response))
        let exp = XCTestExpectation(description: "Completion")
        sut.loadProducts().sinkToResult { result in
            result.assertSuccess(value: response)
            exp.fulfill()
        }.store(in: &subscriptions)
        wait(for: [exp], timeout: 2)
    }
    
    // MARK: - Helper
    
    private func mock<T>(_ apiRequest: API, result: Result<T, Swift.Error>,
                         httpCode: HttpStatusCode = 200) throws where T: Encodable {
        let mock = try Mock(apiRequest: apiRequest, baseURL: sut.baseURL, result: result, httpCode: httpCode)
        RequestMocking.add(mock: mock)
    }
}