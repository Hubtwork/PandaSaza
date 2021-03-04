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
    
    @State private var isLogin = true
    @State private var test = "hi"
    @State private var selectedIdx = 0
    
    @State private var shouldLoginWithModal = false
    @State private var sellItemModal = false
    
    let tabBarImages = ["cart", "doc.plaintext",  "message.fill", "person"]
    let tabBarLabels = ["구매하기", "매거진", "채팅", "내 정보"]
    
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
                
                Spacer()
                    .fullScreenCover(isPresented: $sellItemModal, content: {
                        ProductRegistView()
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
                        
                    case 2:
                        if !isLogin {
                            AuthMainView()
                        }
                        else {
                            ChattingList(viewModel: ChattingListViewModel())
                        }
                    
                    case 3:
                        if !isLogin {
                            AuthMainView()
                        }
                        else {
                            MyPageView(viewModel: MyPageViewModel())
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
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
