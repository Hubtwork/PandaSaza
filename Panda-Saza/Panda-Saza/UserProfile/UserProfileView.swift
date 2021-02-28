//
//  UserProfileView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/28.
//

import SwiftUI

struct UserProfileView: View {
    var body: some View {
        userProfile
    }
}

extension UserProfileView {
    var userProfile: some View {
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
    
    var sellerProfileBase: some View {
        /// Seller Profile View
        HStack {
            HStack(spacing: 0) {
                CircleImageView(imageString: "gucci_02")
                    .frame(width:UIScreen.screenWidth / 4)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("이름")
                        .font(.title2)
                        .bold()
                    Text("동국대학교")
                        .font(.body)
                        .foregroundColor(.gray)
                }
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
                    Image("kr")
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
                    Text(String("3.1"))
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
                Text("학생증")
                    .font(.caption)
                    .bold()
            }
            Spacer()
            
        }.padding(.vertical, UIScreen.screenWidth / 30)
        .padding(.horizontal, UIScreen.screenWidth / 10)
    }
    
    var sellerProfileAuthHistory: some View {
        VStack(alignment: .leading, spacing: 5){
            Text("2021년 2월 3일, 동국대학교 학생증 인증")
                .font(.body)
            HStack(spacing : 0) {
                Text("최근 로그인 ")
                    .font(.body)
                Text(" 2021년 3월 1일")
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
                Text("판매상품 3개")
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
                    Text("받은 평가 0개")
                        .font(.title3)
                        .bold()
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                }
                .padding(.bottom, UIScreen.screenHeight / 40)
                
                Text("받은 평가가 아직 없어요.")
                    .font(.body)
            }
            Divider()
            VStack(alignment: .leading) {
                HStack {
                    Text("받은 후기 0개")
                        .font(.title3)
                        .bold()
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                }
                .padding(.bottom, UIScreen.screenHeight / 40)
                
                Text("받은 리뷰가 아직 없어요.")
                    .font(.body)
            }
        }.padding(.horizontal, UIScreen.screenWidth / 20)
        .padding(.vertical, UIScreen.screenWidth / 20)
    }
    
    /*
     
     
     VStack(alignment: .leading, spacing: 3) {
         HStack {
             Text("국적")
                 .font(Font.system(size: 18))
                 .bold()
             Image("kor")
                 .resizable()
                 .scaledToFit()
                 .frame(width: 20)
         }
         HStack {
             Text("평점")
                 .font(Font.system(size: 18))
                 .bold()
             Image(systemName: "star.fill")
                 .resizable()
                 .scaledToFit()
                 .foregroundColor(.yellow)
                 .frame(width: 18)
             Text(String("3.1"))
                 .font(Font.system(size: 18))
                 .bold()
         }
     }.frame(width: UIScreen.screenWidth / 3)
     .padding(.trailing, 15)
     */
    
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
