//
//  ViewContainer.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/27.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    private let container: DIContainer
    @State private var isSigned: Bool = false
    
    init(container: DIContainer) {
        self.container = container
    }
    
    var body: some View {
        ZStack {
            if !isSigned {
                SignNavMain()
                    .inject(container)
            } else {
                TabViewContainer()
                    .inject(container)
            }
            
            /*
            if !isSigned {
                SignMain()
                    .inject(container)
            } else {
                TabViewContainer()
                    .inject(container)
            }
             */
        }
        .onReceive(signInStateUpdate) { self.isSigned = $0 }
    }
    
    
    private var signInStateUpdate: AnyPublisher<Bool, Never> {
        container.appState.updates(for: \.system.isSigned)
    }
    // if Tokens are valid ( By login or register )
    // will return true
    private var tokenLoader: AnyPublisher<Bool, Never> {
        let token = container.appState.updates(for: \.userData.tokens)
        return token.map { $0 != nil }.eraseToAnyPublisher()
    }
}
