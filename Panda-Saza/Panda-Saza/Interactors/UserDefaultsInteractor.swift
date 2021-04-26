//
//  UserDefaultsInteractor.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/07.
//

import Foundation

protocol UserDefaultsInteractor {
    
    func checkIsSignInfoSaved() -> Bool
    func signOut()
    func signIn(auth: UserAuthType, loginInfo: String)
    
}

enum UserAuthType {
    case kakao
    case facebook
    case google
    case email
}

struct PandasazaUserDefaultsInteractor: UserDefaultsInteractor {

    func signOut() {
        UserDefaults.standard.removeObject(forKey: "signInData")
    }
    
    func signIn(auth: UserAuthType, loginInfo: String) {
        var signString: String = ""
        switch auth {
        case .email: signString += "EMAIL )" + loginInfo
        default: signString += ""
        }
        UserDefaults.standard.set(signString, forKey: "signInData")
    }
    
    
    func checkIsSignInfoSaved() -> Bool {
        isKeyPresentInUserDefaults(key: "signInData")
    }
    
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
}
