//
//  InteractionContainer.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/18.
//

extension DependencyInjector {
    struct Interactors {
        let countriesInteractor: CountriesInteractor
        let imagesInteractor: ImagesInteractor
        let userPermissionsInteractor: UserPermissionsInteractor
        
        init(countriesInteractor: CountriesInteractor,
             imagesInteractor: ImagesInteractor,
             userPermissionsInteractor: UserPermissionsInteractor) {
            self.countriesInteractor = countriesInteractor
            self.imagesInteractor = imagesInteractor
            self.userPermissionsInteractor = userPermissionsInteractor
        }
        
        static var stub: Self {
            .init(countriesInteractor: StubCountriesInteractor(),
                  imagesInteractor: StubImagesInteractor(),
                  userPermissionsInteractor: StubUserPermissionsInteractor())
        }
    }
}
