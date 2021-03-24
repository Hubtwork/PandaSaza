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
    var routing = ViewRouting()
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
    struct ViewRouting: Equatable {
        
    }
}

// MARK: - System Properties
extension AppState {
    struct System: Equatable {
        
    }
}

// MARK: - Permission Manager
extension AppState {
    struct Permissions: Equatable {
        
    }
}

// MARK: - AppState Comprehension

func == (lhs: AppState, rhs: AppState) -> Bool {
    return lhs.userData == rhs.userData &&
        lhs.routing == rhs.routing &&
        lhs.system == rhs.system &&
        lhs.permissions == rhs.permissions
}
