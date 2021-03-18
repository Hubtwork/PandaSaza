//
//  ProductsWebRepository.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/18.
//

import Combine
import Foundation

protocol ProductsApiRepository: ApiRepository {
    func loadProducts() -> AnyPublisher<[Product], Error>
    func loadProductDetails(product: Product) -> AnyPublisher<Product.Details, Error>
}

struct PandasazaProductsApiRepository: ProductsApiRepository {
    
}
