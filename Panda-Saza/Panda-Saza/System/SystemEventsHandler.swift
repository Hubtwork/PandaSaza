//
//  SystemEventHandler.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/26.
//

import UIKit
import Combine

protocol SystemEventsHandler {
    func sceneOpenURLContexts(_ urlContexts: Set<UIOpenURLContext>)
    func sceneDidBecomeActive()
    func sceneWillResignActive()
}

struct PandaSazaEventsHandler: SystemEventsHandler {
    
    let appState: Store<AppState>
    private var subscriptions = Set<AnyCancellable>()
    
    init(appState: Store<AppState>) {
        self.appState = appState
        NotificationCenter.default.keyboardHeightPublisher
            .sink { [appState] height in
                appState[\.system.keyboardHeight] = height
            }.store(in: &subscriptions)
    }
    
    func sceneOpenURLContexts(_ urlContexts: Set<UIOpenURLContext>) {
        guard let url = urlContexts.first?.url else { return }
        handle(url: url)
    }
    // MARK: - TODO : Handling DeepLink URL for Push Notification
    func handle(url: URL) {
        
    }
    
    func currentSelectedTabChanger(tabId: Int) {
        appState[\.routes.selectedTab] = tabId
    }
    
    func sceneDidBecomeActive() {
        appState[\.system.isActive] = true
    }
    
    func sceneWillResignActive() {
        appState[\.system.isActive] = false
    }
}

// MARK: - Notifications

private extension NotificationCenter {
    var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> {
        let willShow = publisher(for: UIApplication.keyboardWillShowNotification)
            .map { $0.keyboardHeight }
        let willHide = publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        return Publishers.Merge(willShow, willHide)
            .eraseToAnyPublisher()
    }
}

private extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?
            .cgRectValue.height ?? 0
    }
}
