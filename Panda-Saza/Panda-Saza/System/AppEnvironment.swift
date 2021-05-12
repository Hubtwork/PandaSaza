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
        //configuration.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: configuration)
    }
    
    private static func configuredApiRepositories(session: URLSession) -> ApiRepositoriesContainer {
        let productsApiRepository = PandasazaProductsApiRepository(
            session: session,
            baseURL: "http://localhost:3000/product")
        let smsApiRepository = PandasazaSmsApiRepository(
            session: session,
            baseURL: "http://localhost:3030/sms")
        let signApiRepository = PandasazaSignApiRepository(
            session: session,
            baseURL: "http://localhost:3030/sign")
        let staticApiRepository = PandasazaStaticApiRepository(
            session: session,
            baseURL: "http://localhost:3000/static")
        return .init(productsApiRepository: productsApiRepository,
                     smsApiRepository: smsApiRepository,
                     signApiRepository: signApiRepository,
                     staticApiRepository: staticApiRepository)
    }
    
    private static func configuredInteractors(appState: Store<AppState>,
                                              apiRepositories: ApiRepositoriesContainer
    ) -> DIContainer.Interactors {
        let productsInteractor = PandaSazaProductsInteractor(
            apiRepository: apiRepositories.productsApiRepository,
            appState: appState)
        let signInteractor = PandaSazaSignInteractor(
            smsRepository: apiRepositories.smsApiRepository,
            signRepository: apiRepositories.signApiRepository,
            appState: appState)
        let staticInteractor = PandaSazaStaticApiInteractor(
            apiRepository: apiRepositories.staticApiRepository,
            appState: appState)
        return .init(productsInteractor: productsInteractor,
                     signInteractor: signInteractor,
                     staticInteractor: staticInteractor)
    }
}

private extension AppEnvironment {
    struct ApiRepositoriesContainer {
        let productsApiRepository: ProductsApiRepository
        let smsApiRepository: SmsApiRepository
        let signApiRepository: SignApiRepository
        let staticApiRepository: StaticApiRepository
    }
}


