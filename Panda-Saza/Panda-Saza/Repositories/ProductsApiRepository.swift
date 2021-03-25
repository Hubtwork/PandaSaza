//
//  ProductsApiRepository.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/25.
//

import Combine
import Foundation

protocol ProductsApiRepository: ApiRepository {
    
    func loadProducts() -> AnyPublisher<[Product], Error>
    func loadProductsFiltered(categoryId: Int) -> AnyPublisher<[Product], Error>
    func loadProductDetails(productId: Int) -> AnyPublisher<ProductDetails, Error>
    
}

struct PandasazaProductsApiRepository: ProductsApiRepository {
    
    let session: URLSession
    let baseURL: String
    
    let backgroundQueue = DispatchQueue(label: "bg_parse_queue")
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func loadProducts() -> AnyPublisher<[Product], Error> {
        return request(endpoint: API.productList)
    }
    
    func loadProductsFiltered(categoryId: Int) -> AnyPublisher<[Product], Error> {
        return request(endpoint: API.productFiltered(categoryId))
    }
    
    func loadProductDetails(productId: Int) -> AnyPublisher<ProductDetails, Error> {
        return request(endpoint: API.productDetail(productId))
    }
    
    
}

// MARK: - Endpoints

extension PandasazaProductsApiRepository {
    enum API {
        case productList
        case productDetail(Int)
        case productFiltered(Int)
    }
}

extension PandasazaProductsApiRepository.API: ApiRequest {
    
    var path: String {
        switch self {
        case .productList:
            return "/products"
        case let .productDetail(productId):
            return "/\(productId)"
        case let .productFiltered(categoryId):
            return "/category/\(categoryId)"
        }
    }
    
    var method: String {
        switch self {
        case .productList, .productFiltered, .productDetail:
            return "GET"
        }
    }
    
    var headers: [String: String]? {
        return ["Accept": "application/json"]
    }
    
    func body() throws -> Data? {
        return nil
    }
}
