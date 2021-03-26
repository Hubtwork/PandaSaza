//
//  ProductsInteractor.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/26.
//

import Combine
import Foundation
import SwiftUI

protocol ProductsInteractor {
    func loadProducts()
    func load(productDetail: LoadableSubject<ProductDetails>, productId: Int)
    
}

struct PandaSazaProductsInteractor: ProductsInteractor {
    
    
    let apiRepository: ProductsApiRepository
    let appState: Store<AppState>
    
    private var requestHoldBackTimeInterval: TimeInterval {
        return 0.5
    }
    
    init(apiRepository: ProductsApiRepository, appState: Store<AppState>) {
        self.apiRepository = apiRepository
        self.appState = appState
    }
    
    func loadProducts() {
        let cancelBag = CancelBag()
        appState[\.loadedData.products].setIsLoading(cancelBag: cancelBag)
        weak var weakAppState = appState
        apiRepository.loadProducts()
            .sinkToLoadable { weakAppState?[\.loadedData.products] = $0 }
            .store(in: cancelBag)
    }
    
    
    func load(productDetail: LoadableSubject<ProductDetails>, productId: Int) {
        let cancelBag = CancelBag()
        productDetail.wrappedValue.setIsLoading(cancelBag: cancelBag)
        apiRepository.loadProductDetails(productId: productId)
            .sinkToLoadable { productDetail.wrappedValue = $0 }
            .store(in: cancelBag)
    }
    
}

struct StubProductsInteractor: ProductsInteractor {
    
    func loadProducts() {
    }
    
    func load(productDetail: LoadableSubject<ProductDetails>, productId: Int) {
    }
}
