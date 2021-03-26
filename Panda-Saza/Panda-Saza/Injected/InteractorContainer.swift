//
//  InteractorContainer.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/23.
//



// MARK: - Interactor Container for Dependency Injector

extension DIContainer {
    struct Interactors {
        
        let productsInteractor: ProductsInteractor
        
        init(productsInteractor: ProductsInteractor) {
            self.productsInteractor = productsInteractor
        }
        
        static var stub: Self {
            .init(productsInteractor: StubProductsInteractor())
        }
    }
    
}
    
