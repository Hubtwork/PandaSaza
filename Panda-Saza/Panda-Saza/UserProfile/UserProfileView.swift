//
//  UserProfileView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/28.
//

import SwiftUI

struct UserProfileView: View {
    
    @ObservedObject var viewModel: UserProfileViewModel
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        userProfile
    }
}

extension UserProfileView {
    var userProfile: some View {
        VStack(spacing: 0) {
            
            /// Header :: Navigation Toolbar
            self.topStickyToolbar
            Divider()
                .background(Color.black)
            /// Body :: Profile View
            ScrollView {
                VStack {
                    self.sellerProfileBase
                    
                    self.sellerProfileInfo
                    self.sellerProfileAuth
                    
                    self.sellerProfileAuthHistory
                    self.sellerProfileSellHistory
                }
            }
        }
    }
    
    var sellerProfileBase: some View {
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
    
    var sellerProfileInfo: some View {
        /// Seller Profile Info
        HStack {
            HStack(spacing: 0) {
                HStack(spacing: 3){
                    Text("국적")
                        .font(.body)
                        .bold()
                    Image(self.viewModel.user!.userLocale)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                }
                Spacer()
                HStack(spacing: 3){
                    Text("평점")
                        .font(.body)
                        .bold()
                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.yellow)
                        .frame(width: 18)
                        .padding(.leading, 10)
                    Text(String(self.viewModel.user!.userRating))
                        .font(.body)
                        .bold()
                }
            }
            Spacer()
            
            
        }.padding(.vertical, UIScreen.screenWidth / 30)
        .padding(.horizontal, UIScreen.screenWidth / 10)
        
    }
    
    var sellerProfileAuth: some View {
        HStack {
            
            HStack(spacing: 10) {
                Text("인증 뱃지")
                    .font(.body)
                    .bold()
                
                if self.viewModel.user!.userAuthMethods.count > 0 {
                    ForEach(self.viewModel.user!.userAuthMethods, id: \.self) { userAuth in
                        
                        Text(userAuth)
                            .font(.caption)
                            .bold()
                            .padding(5)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.2)))
                    }
                }
            }
            Spacer()
            
        }.padding(.vertical, UIScreen.screenWidth / 30)
        .padding(.horizontal, UIScreen.screenWidth / 10)
    }
    
    var sellerProfileAuthHistory: some View {
        VStack(alignment: .leading, spacing: 5){
            if self.viewModel.user!.userAuthHistory.count == 0 {
                Text("미인증 회원입니다")
                    .font(.body)
            }
            else {
                ForEach(self.viewModel.user!.userAuthHistory, id: \.self) {
                    userAuth in
                    
                    Text(userAuth)
                        .font(.body)
                }
            }
            HStack(spacing : 0) {
                Text("최근 로그인 ")
                    .font(.body)
                Text(self.viewModel.user!.userLoginRecent)
                    .font(.body)
                    .bold()
                Spacer()
            }
            
        }
        .padding(.horizontal, UIScreen.screenWidth / 30)
        .padding(.vertical, UIScreen.screenWidth / 20)
        .frame(width: UIScreen.screenWidth)
        .background(Color.gray.opacity(0.2))
    }
    
    var sellerProfileSellHistory: some View {
        VStack(alignment: .leading, spacing: UIScreen.screenHeight / 40) {
            HStack {
                Text(String(format: "%@ %d%@", "판매상품", self.viewModel.user!.sellItems.count, "개"))
                    .font(.title3)
                    .bold()
                Spacer()
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
            }
            Divider()
            VStack(alignment: .leading){
                HStack {
                    Text(String(format: "%@ %d%@", "받은 평가", self.viewModel.user!.rateHistory.count, "개"))
                        .font(.title3)
                        .bold()
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                }
                .padding(.bottom, UIScreen.screenHeight / 40)
                /// TODO - 평가 개수가 0개가 아닐 때, 평가 상위 3개 미리보기
                if self.viewModel.user!.rateHistory.count == 0 {
                    Text("받은 평가가 아직 없어요.")
                        .font(.body)
                }
            }
            Divider()
            VStack(alignment: .leading) {
                HStack {
                    Text(String(format: "%@ %d%@", "받은 리뷰", self.viewModel.user!.reviewHistory.count, "개"))
                        .font(.title3)
                        .bold()
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                }
                .padding(.bottom, UIScreen.screenHeight / 40)
                
                /// TODO - 리뷰 개수가 0개가 아닐 때, 리뷰 상위 3개 미리보기
                if self.viewModel.user!.reviewHistory.count == 0 {
                    Text("받은 리뷰가 아직 없어요.")
                        .font(.body)
                }
            }
        }.padding(.horizontal, UIScreen.screenWidth / 20)
        .padding(.vertical, UIScreen.screenWidth / 20)
    }
    
    var topStickyToolbar: some View {
        
            HStack{
                Button(action: { presentation.wrappedValue.dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(Font.system(size: UIScreen.screenWidth / 15))
                }.foregroundColor(.black)
                Spacer()
                Text("프로필")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            
    }
    
    
}
