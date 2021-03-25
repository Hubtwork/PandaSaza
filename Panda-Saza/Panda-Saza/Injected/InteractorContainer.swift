//
//  InteractorContainer.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/23.
//



// MARK: - Interactor Container for Dependency Injector

extension DIContainer {
    struct Interactors {
        
        let permissionsInteractor: PermissionsInteractor
        
        init(permissionsInteractor: PermissionsInteractor) {
            self.permissionsInteractor = permissionsInteractor
        }
        
        static var stub: Self {
            .init(permissionsInteractor: StubPermissionsInteractor())
        }
    }
    
}
    
