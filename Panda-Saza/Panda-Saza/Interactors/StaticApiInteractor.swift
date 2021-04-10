//
//  StaticApiInteractor.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/10.
//

import Combine
import Foundation
import SwiftUI

protocol StaticApiInteractor {
    
    func getSchools()
    
}

struct PandaSazaStaticApiInteractor: StaticApiInteractor {
    
    let apiRepository: StaticApiRepository
    let appState: Store<AppState>
    
    private var requestHoldBackTimeInterval: TimeInterval {
        return 0.5
    }
    
    init(apiRepository: StaticApiRepository, appState: Store<AppState>) {
        self.apiRepository = apiRepository
        self.appState = appState
    }
    
    func getSchools() {
        let cancelBag = CancelBag()
        apiRepository.getSchools()
            .sinkToResult { print($0) }
            .store(in: cancelBag)
    }
    
}

struct StubPandaSazaStaticApiInteractor: StaticApiInteractor {
    
    func getSchools() {
        
    }
    
}
