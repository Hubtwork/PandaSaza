//
//  AppState.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/23.
//

import SwiftUI
import Combine

struct AppState: Equatable {
    var userData = UserData()
    var routes = ViewRoutes()
    var system = System()
    var permissions = Permissions()
    var loadedData = LoadedData()
}

// MARK: - Loaded Data
extension AppState {
    struct LoadedData: Equatable {
        var products: Loadable<[Product]> = .notRequested
        var productDetails: Loadable<ProductDetails> = .notRequested
    }
}

// MARK: - User Data
extension AppState {
    struct UserData: Equatable {
        
    }
}

// MARK: - View Routings
extension AppState {
    struct ViewRoutes: Equatable {
        var selectedTab: Int = 0
        
    }
}

// MARK: - System Properties
extension AppState {
    struct System: Equatable {
        var keyboardHeight: CGFloat = 0
        var isActive: Bool = true
        var isLogin: Bool = false
        var isAuth: Bool = false
    }
}

// MARK: - Permission Manager
extension AppState {
    struct Permissions: Equatable {
        var push: Permission.Status = .unknown
    }
    
    static func permissionKeyPath(for permission: Permission) -> WritableKeyPath<AppState, Permission.Status> {
        let pathToPermissions = \AppState.permissions
        switch permission {
        case .pushNotifications:
            return pathToPermissions.appending(path: \.push)
        }
    }
}

// MARK: - AppState Comprehension

func == (lhs: AppState, rhs: AppState) -> Bool {
    return lhs.userData == rhs.userData &&
        lhs.routes == rhs.routes &&
        lhs.system == rhs.system &&
        lhs.permissions == rhs.permissions &&
        lhs.loadedData == rhs.loadedData
}

#if DEBUG
extension AppState {
    static var preview: AppState {
        var state = AppState()
        state.system.isActive = true
        return state
    }
}
#endif
