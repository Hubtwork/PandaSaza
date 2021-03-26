//
//  AppEnvironment.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/26.
//

import UIKit
import Combine

struct AppEnvironment {
    let container: DIContainer
    let systemEventsHandler: SystemEventsHandler
}


extension AppEnvironment {
    
    static func bootstrap() -> AppEnvironment {
        let appState = Store<AppState>(AppState())
        let session = configuredURLSession()
        let apiRepositories = configuredApiRepositories(session: session)
        let interactors = configuredInteractors(appState: appState, apiRepositories: apiRepositories)
        let systemEventsHandler = PandaSazaEventsHandler(appState: appState)
        let diContainer = DIContainer(appState: appState, interactors: interactors)
        return AppEnvironment(container: diContainer,
                              systemEventsHandler: systemEventsHandler)
    }
    
    private static func configuredURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: configuration)
    }
    
    private static func configuredApiRepositories(session: URLSession) -> ApiRepositoriesContainer {
        let productsApiRepository = PandasazaProductsApiRepository(
            session: session,
            baseURL: "https://restcountries.eu/rest/v2")
        return ApiRepositoriesContainer(productsApiRepository: productsApiRepository)
    }
    
    private static func configuredInteractors(appState: Store<AppState>,
                                              apiRepositories: ApiRepositoriesContainer
    ) -> DIContainer.Interactors {
        let productsInteractor = PandaSazaProductsInteractor(
            apiRepository: apiRepositories.productsApiRepository,
            appState: appState)
        return .init(productsInteractor: productsInteractor)
    }
}

private extension AppEnvironment {
    struct ApiRepositoriesContainer {
        let productsApiRepository: ProductsApiRepository
    }
}


