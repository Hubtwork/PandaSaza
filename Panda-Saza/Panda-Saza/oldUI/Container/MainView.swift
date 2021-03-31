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
    @State private var authCompleted = false
    @State private var test = "hi"
    @State private var selectedIdx = 0
    
    @State private var shouldLoginWithModal = false
    @State private var sellItemModal = false
    
    let tabBarImages = ["cart", "doc.plaintext", "plus.circle", "message.fill", "person"]
    let tabBarLabels = ["상품구매", "찜 목록", "상품판매", "채팅", "내 정보"]

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
                        ShoppingHomeView(viewModel: ShoppingHomeViewModel(), authCompleted: $authCompleted)
                        
                    case 1:
                        LikeView()
                        //SlidingTab()
                    case 3:
                        ChattingList(viewModel: ChattingListViewModel())
                    
                    case 4:
                        MyPageView(viewModel: MyPageViewModel())
                    
                    default:
                        NavigationView {
                            Text("Remaining tabs")
                            
                        }
                }
                
            }
            BottomTabBar(selectedIndex: $selectedIdx, isLogin: $isLogin, shouldLoginModal: $shouldLoginWithModal, itemSellingModal: $sellItemModal, tabBarSystemIcons: tabBarImages, tabBarLabels: tabBarLabels, color: .black)
                .padding(.top, 10)
        }.onAppear() {
          for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            // print array of names
            print("Family: \(family) Font names: \(names)")
          }
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
