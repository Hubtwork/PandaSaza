//
//  MainView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/24.
//

import SwiftUI
import Combine

struct MainView: View {
    
    init() {
        UITabBar.appearance().barTintColor = .systemBackground
        UINavigationBar.appearance().barTintColor = .systemBackground
        /// check icon count == label count
        assert(tabBarImages.count == tabBarLabels.count)
        /// Initialize TabBarItems
        for idx in 0 ..< tabBarImages.count {
            tabBarItems.append(BottomTabBarItem(icon: tabBarImages[idx], title: tabBarLabels[idx], color: .black))
        }
    }
    
    private var tabBarItems: [BottomTabBarItem] = []
    
    @State private var isLogin = false
    @State private var test = "hi"
    @State private var selectedIdx = 0
    
    @State private var shouldLoginWithModal = false
    
    let tabBarImages = ["cart", "doc.plaintext", "plus.app.fill", "message.fill", "person"]
    let tabBarLabels = ["구매하기", "가맹점", "판매하기", "채팅", "내 정보"]
    
    var selectedItem: BottomTabBarItem {
        tabBarItems[selectedIdx]
    }
    
    var body: some View {
        NavigationView{
        VStack(spacing: 0){
            
            ZStack {
                Spacer()
                    .fullScreenCover(isPresented: $shouldLoginWithModal, content: {
                        AuthMainView()
                })
                
                switch selectedIdx {
                    case 0:
                        ShoppingHomeView(viewModel: ShoppingHomeViewModel())
                        
                    case 1:
                        if !isLogin {
                            AuthMainView()
                        }
                        else {
                            ScrollView {
                                Text("TEST")
                            }
                        }
                        
                    default:
                        NavigationView {
                            Text("Remaining tabs")
                            
                        }
                }
            }
            BottomTabBar(selectedIndex: $selectedIdx, isLogin: $isLogin, shouldLoginModal: $shouldLoginWithModal, tabBarSystemIcons: tabBarImages, tabBarLabels: tabBarLabels, color: .black)
                .padding(.top, 10)
            
        }
        
        .navigationBarHidden(true)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
