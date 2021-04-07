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
    func signIn(id: String, pw: String)
    
}

struct PandasazaUserDefaultsInteractor: UserDefaultsInteractor {
    func signOut() {
        UserDefaults.standard.removeObject(forKey: "signInData")
    }
    
    func signIn(id: String, pw: String) {
        let signString: String = "id=\(id)&pw=\(pw)"
        UserDefaults.standard.set(signString, forKey: "signInData")
    }
    
    
    func checkIsSignInfoSaved() -> Bool {
        isKeyPresentInUserDefaults(key: "signInData")
    }
    
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
}
