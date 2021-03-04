//
//  EmailChangeView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/04.
//

import SwiftUI

struct EmailChangeView: View {
    
    @Environment(\.presentationMode) var presentation
    @Binding var accountEmail: String
    @Binding var accountPhone: String
    
    var body: some View {
        layout
            .navigationBarHidden(true)
    }
}

extension EmailChangeView {
    
    var layout: some View {
        VStack(spacing: 0){
            titleBar
            Divider()
            
            accountSection
                .padding(.top, 30)
            profileEmailView
                .padding(.top, 20)
            profilePhoneView
                .padding(.top, 20)
            
            sideSection
                .padding(.top, 30)
            
            serviceDocument
                .padding(.top, 20)
            
            Spacer()
        }
    }
    
    var accountSection: some View {
        HStack {
            Text("계정 정보")
                .font(.title2)
                .bold()
            Spacer()
        }.padding(.leading, 10)
    }
    
    var profileEmailView: some View {
        VStack(spacing: 10){
            HStack {
                Text("이메일")
                    .font(.title2)
                Spacer()
                Text("변경")
                    .font(.title2)
                    .foregroundColor(.red)
            }
            HStack {
                Text(accountEmail)
                    .font(.title3)
                    .foregroundColor(.gray)
                Spacer()
            }
        }.padding(.horizontal, 10)
    }
    
    var profilePhoneView: some View {
        VStack(spacing: 10){
            HStack {
                Text("전화번호")
                    .font(.title2)
                Spacer()
                Text("변경")
                    .font(.title2)
                    .foregroundColor(.red)
            }
            HStack {
                Text(accountPhone)
                    .font(.title3)
                    .foregroundColor(.gray)
                Spacer()
            }
        }.padding(.horizontal, 10)
    }
    
    var sideSection: some View {
        HStack {
            Text("기타 정보")
                .font(.title2)
                .bold()
            Spacer()
        }.padding(.leading, 10)
    }
    
    var serviceDocument: some View {
        HStack {
            Text("서비스 이용약관")
                .font(.title3)
            Spacer()
        }.padding(.leading, 10)
    }    
    
    var titleBar: some View {
        ZStack {
            HStack {
                Button(action: { presentation.wrappedValue.dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(Font.system(size: UIScreen.screenWidth / 15))
                }.foregroundColor(.black)
                Spacer()
                Text("완료")
                    .font(.title2)
                    
            }.padding(.vertical, 10)
            .padding(.horizontal, 10)
            
            HStack {
                Spacer()
                Text("계정 정보 수정")
                    .font(.title2)
                    .bold()
                Spacer()
            }.padding(.vertical, 10)
        }
    }
}

struct EmailChangeView_Previews: PreviewProvider {
    static var previews: some View {
        EmailChangeView(accountEmail: .constant("asdasd301@naver.com"), accountPhone: .constant("010-3733-2942"))
    }
}
