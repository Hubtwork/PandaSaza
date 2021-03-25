//
//  DependencyManager.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/23.
//

import SwiftUI
import Combine

/**
 
Dependency Injector for Views
 
 DIContainer has dependencies needed for Views.


 */
// MARK: - DIContainer

struct DIContainer: EnvironmentKey {
    
    let appState: Store<AppState>
    let interactors: Interactors
    
    init(appState: Store<AppState>, interactors: Interactors) {
        self.appState = appState
        self.interactors = interactors
    }
    
    init(appState: AppState, interactors: Interactors) {
        self.init(appState: Store<AppState>(appState), interactors: interactors)
    }
    
    static var defaultValue: Self { Self.default }
    
    private static let `default` = Self(appState: AppState(), interactors: .stub)
    
}

extension EnvironmentValues {
    var injected: DIContainer {
        get { self[DIContainer.self] }
        // use Parameter Computed Property
        set { self[DIContainer.self] = newValue }
    }
}

// MARK: - Injection in the view hierarchy

extension View {
    
    func inject(_ appState: AppState,
                _ interactors: DIContainer.Interactors) -> some View {
        let container = DIContainer(appState: .init(appState),
                                    interactors: interactors)
        return inject(container)
    }
    
    func inject(_ container: DIContainer) -> some View {
        return self
            .modifier(RootViewAppearance())
            .environment(\.injected, container)
    }
}
