//
//  SignInteractor.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/03.
//

import Combine
import Foundation
import SwiftUI

protocol SignInteractor {
    
    /*
    func signIn(user: LoadableSubject<UserModel>, id: String, pw: String)
    func sign(id: String, pw: String)
    func authSMS(phone: String, response: LoadableSubject<JsonSMSValidation>)
    */
}

struct PandaSazaSignInteractor: SignInteractor {
    
    let apiRepository: SignApiRepository
    let appState: Store<AppState>
    
    private var requestHoldBackTimeInterval: TimeInterval {
        return 0.5
    }
    
    init(apiRepository: SignApiRepository, appState: Store<AppState>) {
        self.apiRepository = apiRepository
        self.appState = appState
    }
    
    /*
    func sign(id: String, pw: String) {
        let cancelBag = CancelBag()
        apiRepository.signIn(id: id, password: pw)
            .sinkToResult { print($0) }
            .store(in: cancelBag)
    }
    
    func signIn(user: LoadableSubject<UserModel>, id: String, pw: String) {
        let cancelBag = CancelBag()
        user.wrappedValue.setIsLoading(cancelBag: cancelBag)
        apiRepository.signIn(id: id, password: pw)
            .sinkToLoadable { user.wrappedValue = $0 }
            .store(in: cancelBag)
    }
    
    func authSMS(phone: String, response: LoadableSubject<JsonSmsValidation>) {
        let cancelBag = CancelBag()
        response.wrappedValue.setIsLoading(cancelBag: cancelBag)
        apiRepository.auth(phone: phone)
            .ensureTimeSpan(1)
            .sinkToLoadable { response.wrappedValue = $0 }
            .store(in: cancelBag)
     }
 */
}

struct StubSignInteractor: SignInteractor {
    /*
    func sign(id: String, pw: String) {
        
    }
    
    func signIn(user: LoadableSubject<UserModel>, id: String, pw: String) {
        
    }
    func authSMS(phone: String, response: LoadableSubject<JsonSmsValidation>) {
        
    }
    */
}
