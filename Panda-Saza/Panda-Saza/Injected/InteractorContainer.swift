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
        let signInteractor: SignInteractor
        
        init(productsInteractor: ProductsInteractor,
             signInteractor: SignInteractor
        ) {
            self.productsInteractor = productsInteractor
            self.signInteractor = signInteractor
        }
        
        static var stub: Self {
            .init(productsInteractor: StubProductsInteractor(), signInteractor: StubSignInteractor())
        }
    }
    
}
    
