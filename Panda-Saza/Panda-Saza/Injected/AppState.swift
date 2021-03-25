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
        
        var isActive: Bool = false
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
        lhs.permissions == rhs.permissions
}
