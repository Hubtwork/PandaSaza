//
//  TabBar.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/27.
//

import SwiftUI
import Combine

struct TabBar: View {
    @State private var selectedIndex: Int = 0
    @State private var isLogin: Bool = false
    
    @Environment(\.injected) private var injected: DIContainer
    
    private let tabBarItems: [BottomTabBarItem]
    
    public init() {
        let tabBarImages = ["cart", "doc.plaintext", "plus.circle", "message.fill", "person"]
        let tabBarLabels = ["Purchase", "Likes", "Sale", "Chat", "Profile"]
        let color = Color.black
        /// check icon count == label count
        assert(tabBarImages.count == tabBarLabels.count)
        /// Initialize TabBarItems
        var items: [BottomTabBarItem] = []
        for idx in 0 ..< tabBarImages.count {
            items.append(BottomTabBarItem(icon: tabBarImages[idx], title: tabBarLabels[idx], color: color))
        }
        self.tabBarItems = items
    }
    
    /// Initialize TabBarItemView
    func TabBarItemView(at index: Int) -> some View {
        Button(action: {
            tabSelect(tabId: index)
        }) {
            BottomTabBarItemView(isSelected: index == selectedIndex, item: tabBarItems[index])
        }
    }
    
    /// Skelleton View for TabBar
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            HStack {
                ForEach(0..<tabBarItems.count) { idx in
                    if idx == 0 { Spacer() }
                    self.TabBarItemView(at: idx)
                    Spacer()
                }
            }
            .padding(.top, UIScreen.screenWidth * 0.02)
            .padding(.bottom)
            .background(Color.white)
            .frame(width: UIScreen.screenWidth)
        }
        .edgesIgnoringSafeArea(.bottom)
        .onReceive(selectedTabUpdate) {
            self.selectedIndex = $0
        }
    }
}

extension TabBar {
    
    var selectedTabUpdate: AnyPublisher<Int, Never> {
        injected.appState.updates(for: \.routes.selectedTab)
    }
    
    func tabSelect(tabId: Int) {
        injected.appState[\.routes].selectedTab = tabId
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
            .inject(.preview)
    }
}
