//
//  BottomTabBar.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/25.
//

import SwiftUI

struct BottomTabBar: View {
    
    @Binding private var selectedIndex: Int
    @Binding private var shouldLoginModal: Bool
    @Binding private var itemSellingModal: Bool
    @Binding private var isLogin: Bool
    
    private let tabBarItems: [BottomTabBarItem]
    
    public init(selectedIndex: Binding<Int>, isLogin: Binding<Bool>, shouldLoginModal: Binding<Bool>, itemSellingModal: Binding<Bool>, tabBarSystemIcons: [String], tabBarLabels: [String], color: Color) {
        self._shouldLoginModal = shouldLoginModal
        self._isLogin = isLogin
        self._selectedIndex = selectedIndex
        self._itemSellingModal = itemSellingModal
        /// check icon count == label count
        assert(tabBarSystemIcons.count == tabBarLabels.count)
        /// Initialize TabBarItems
        var items: [BottomTabBarItem] = []
        for idx in 0 ..< tabBarSystemIcons.count {
            items.append(BottomTabBarItem(icon: tabBarSystemIcons[idx], title: tabBarLabels[idx], color: color))
        }
        self.tabBarItems = items
    }
    
    /// Initialize TabBarItemView
    func TabBarItemView(at index: Int) -> some View {
        Button(action: {
            if !self.isLogin {
                self.shouldLoginModal.toggle()
            }
            else {
                if index == 2 {
                    self.itemSellingModal.toggle()
                }
                else {
                    self.selectedIndex = index
                }
            }
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
    }
}

struct BottomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        BottomTabBar(selectedIndex: .constant(1),
                     isLogin: .constant(true),
                     shouldLoginModal: .constant(false),
                     itemSellingModal: .constant(false),
                     tabBarSystemIcons: ["cart", "heart.circle", "plus.app.fill", "message.fill", "person"],
                     tabBarLabels: ["구매하기", "찜 목록", "판매하기", "채팅", "내 정보"],
                     color: .black)
    }
}
