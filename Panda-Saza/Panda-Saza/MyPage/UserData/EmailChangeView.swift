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
            
            TitleContentsContainer(title: "계정 정보") {
                profileEmailView
                profilePhoneView
            }
            
            TitleContentsContainer(title: "기타 정보") {
                serviceDocument
            }
            
            Spacer()
        }
    }
    
    var profileEmailView: some View {
        VStack(spacing: 10){
            HStack {
                Text("이메일")
                    .bold()
                Spacer()
                Text("변경")
                    .foregroundColor(.red)
            }
            HStack {
                Text(accountEmail)
                    .foregroundColor(.gray)
                Spacer()
            }
        }
    }
    
    var profilePhoneView: some View {
        VStack(spacing: 10){
            HStack {
                Text("전화번호")
                    .bold()
                Spacer()
                Text("변경")
                    .foregroundColor(.red)
            }
            HStack {
                Text(accountPhone)
                    .foregroundColor(.gray)
                Spacer()
            }
        }
    }
    
    var serviceDocument: some View {
        HStack {
            Text("서비스 이용약관")
                .font(.title3)
            Spacer()
        }
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
