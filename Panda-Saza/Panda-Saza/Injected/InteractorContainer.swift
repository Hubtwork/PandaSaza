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
        let staticInteractor: StaticApiInteractor
        
        init(productsInteractor: ProductsInteractor,
             signInteractor: SignInteractor,
             staticInteractor: StaticApiInteractor
        ) {
            self.productsInteractor = productsInteractor
            self.signInteractor = signInteractor
            self.staticInteractor = staticInteractor
        }
        
        static var stub: Self {
            .init(productsInteractor: StubProductsInteractor(),
                  signInteractor: StubSignInteractor(),
                  staticInteractor: StubStaticApiInteractor())
        }
    }
    
}
    
