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
    
    /// SMS Validations
    func smsVerification(phone: String, registered: LoadableSubject<Bool>)
    func smsValidation(phone: String, validationCode: LoadableSubject<String>)
    
    func registration(registration: RegistrationModel, profileImage: UIImage, isLogin: LoadableSubject<Bool>)
}

struct PandaSazaSignInteractor: SignInteractor {
    
    let smsRepository: SmsApiRepository
    let signRepository: SignApiRepository
    let appState: Store<AppState>
    
    private var requestHoldBackTimeInterval: TimeInterval {
        return 0.5
    }
    
    init(
        smsRepository: SmsApiRepository,
        signRepository: SignApiRepository,
        appState: Store<AppState>) {
        self.smsRepository = smsRepository
        self.signRepository = signRepository
        self.appState = appState
    }
    
    func smsVerification(phone: String, registered: LoadableSubject<Bool>) {
        let cancelBag = CancelBag()
        registered.wrappedValue.setIsLoading(cancelBag: cancelBag)
        
        smsRepository.verifyingSMS(phone: phone)
            .sinkToLoadable{ registered.wrappedValue = $0 }
            .store(in: cancelBag)
    }
    
    func smsValidation(phone: String, validationCode: LoadableSubject<String>) {
        let cancelBag = CancelBag()
        validationCode.wrappedValue.setIsLoading(cancelBag: cancelBag)
        
        smsRepository.requestSMSValidation(phone: phone)
            .sinkToLoadable{ validationCode.wrappedValue = $0 }
            .store(in: cancelBag)
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
    
    func smsValidation(phone: String, validationCode: LoadableSubject<String>) {
        
    }
    
    func smsVerification(phone: String, registered: LoadableSubject<Bool>) {
        
    }
    
    /*
    func sign(id: String, pw: String) {
        
    }
    
    func signIn(user: LoadableSubject<UserModel>, id: String, pw: String) {
        
    }
    func authSMS(phone: String, response: LoadableSubject<JsonSmsValidation>) {
        
    }
    */
}
