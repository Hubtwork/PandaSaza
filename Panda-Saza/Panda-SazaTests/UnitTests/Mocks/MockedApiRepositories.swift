//
//  MockedApiRepositories.swift
//  Panda-SazaTests
//
//  Created by Jae Heo on 2021/03/25.
//

import XCTest
import Combine
@testable import Panda_Saza

class TestApiRepository: ApiRepository {
    let session: URLSession = .mockedResponsesOnly
    let baseURL = "https://test.com"
    let backgroundQueue = DispatchQueue(label: "test")
}

// MARK: - ProductsApiRepository

final class MockedProductsApiRepository: TestApiRepository, Mock, ProductsApiRepository {
    
    enum Action: Equatable {
        case loadProducts
        case loadProductsFiltered(Int)
        case loadProductDetails(Int)
    }
    var actions = MockActions<Action>(expected: [])
    
    var productsResponse: Result<[Product], Error> = .failure(MockError.valueNotSet)
    var productsCategoryResponse: Result<[Product], Error> = .failure(MockError.valueNotSet)
    var detailsResponse: Result<ProductDetails, Error> = .failure(MockError.valueNotSet)
    
    func loadProducts() -> AnyPublisher<[Product], Error> {
        register(.loadProducts)
        return productsResponse.publish()
    }
    
    func loadProductsFiltered(categoryId: Int) -> AnyPublisher<[Product], Error> {
        register(.loadProductsFiltered(categoryId))
        return productsCategoryResponse.publish()
    }
    
    func loadProductDetails(productId: Int) -> AnyPublisher<ProductDetails, Error> {
        register(.loadProductDetails(productId))
        return detailsResponse.publish()
    }
}
