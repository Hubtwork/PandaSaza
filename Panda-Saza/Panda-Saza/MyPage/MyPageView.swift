//
//  SwiftUIView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/02.
//

import SwiftUI

struct MyPageView: View {
    
    @ObservedObject var viewModel: MyPageViewModel
    
    var body: some View {
        
        myPageView
        
    }
}

extension MyPageView {
    
    var myPageView: some View {
        VStack(spacing: 0) {
            self.topStickyToolbar
            Divider()
            ScrollView {
                
                self.userProfileBase
                
                self.userProfileShowButton
                    .padding(.top, 10)
                /// About Items
                self.userProfileButtons
                    .padding(.vertical, 15)
                
                backgroundDivider
                self.userDataSettings
                
                backgroundDivider
                self.userProfileAuthSettings
                
            }
        }
    }
    
    var backgroundDivider: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.1))
            .frame(width: UIScreen.screenWidth, height: 10)
    }
    
    var userProfileBase: some View {
        /// Seller Profile View
        HStack {
            HStack(spacing: 0) {
                CircleImageView(imageString: self.viewModel.user!.userProfileIcon)
                    .frame(width:UIScreen.screenWidth / 6, height: UIScreen.screenWidth / 6)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(self.viewModel.user!.userName)
                        .font(.title2)
                        .bold()
                    Text(self.viewModel.user!.userSchool)
                        .font(.body)
                        .foregroundColor(.gray)
                }.padding(.leading, 10)
            }
            Spacer()
            
            
        }.padding(.vertical, UIScreen.screenWidth / 20)
        .padding(.leading, UIScreen.screenWidth / 20)
    }
    
    var userProfileShowButton: some View {
        HStack {
            Spacer()
            NavigationLink(destination:
                            UserProfileView(viewModel: UserProfileViewModel(uId: self.viewModel.user!.uId))
                                .navigationBarHidden(true)
            ) {
                Text("프로필 보기")
                    .font(.title3)
                    .padding(.vertical, 5)
                    .frame(width: UIScreen.screenWidth * 0.7)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 1)
                    )
            }
            Spacer()
        }
    }
    
    var userProfileButtons: some View {
        HStack {
            Spacer()
            NavigationLink(destination:
                            ItemPurchasedView()
                                .navigationBarHidden(true)
            ) {
                VStack {
                    Image(systemName: "bag.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.black)
                        .frame(width: UIScreen.screenWidth * 0.1)
                    Text("구매 내역")
                        .font(.title3)
                        .foregroundColor(.black)
                }
            }
            Spacer()
            NavigationLink(destination:
                            ItemSaledView()
                                .navigationBarHidden(true)
            ) {
                VStack {
                    Image(systemName: "cart.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.black)
                        .frame(height: UIScreen.screenWidth * 0.1)
                    Text("판매 내역")
                        .font(.title3)
                        .foregroundColor(.black)
                }
            }
            Spacer()
        }
    }
    
    var userDataSettings: some View {
        VStack(spacing: 20){
            HStack(alignment: .center) {
                NavigationLink(destination:
                                ProfileChangeView(profileImageURL: self.viewModel.user!.userProfileIcon, profileName: self.viewModel.user!.userName)
                ) {
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.black)
                        .frame(height: 20)
                    Text("프로필 수정")
                        .font(.title3)
                }.foregroundColor(.black)
                Spacer()
            }
            
            HStack(alignment: .center) {
                NavigationLink(destination:
                                EmailChangeView(accountEmail: .constant(self.viewModel.user!.userEmail), accountPhone: .constant("010-3512-3221"))
                ){
                    Image(systemName: "envelope.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.black)
                        .frame(height: 20)
                    Text("계정 정보 수정")
                        .font(.title3)
                }.foregroundColor(.black)
                Spacer()
            }
            
        }.padding(.vertical, 15)
        .padding(.leading, 20)
    }
    
    var userProfileAuthSettings: some View {
        VStack(spacing: 20){
            HStack(alignment: .center) {
                Image(systemName: "lock.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.black)
                    .frame(height: 20)
                Text("인증 센터")
                    .font(.title3)
                Spacer()
            }
            
            
            HStack(alignment: .center) {
                Image(systemName: "bell.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.black)
                    .frame(height: 20)
                Text("알림 센터")
                    .font(.title3)
                Spacer()
            }
        
        }.padding(.vertical, 10)
        .padding(.leading, 20)
    }
    

    var topStickyToolbar: some View {
        ZStack {
            HStack{
                Spacer()
                Text("나의 판다사자")
                    .font(.title3)
                    .bold()
                Spacer()
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            
            NavigationLink(destination: ConfigurationView().navigationBarHidden(true)
            ) {
                HStack {
                    Spacer()
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.black)
                        .frame(height: 20)
                }.padding(.trailing, 15)
            }
        }
    }
}
