//
//  ProfileRegisterView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/13.
//

import SwiftUI
import URLImage

struct ProfileRegisterView: View {
    
    @Environment(\.injected) private var injected: DIContainer
    @Environment(\.presentationMode) private var presentation
    
    
    let phoneNumber: String
    let school: String
    
    
    var body: some View {
        content
            .foregroundColor(Color.black)
            .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

// MARK:- Screens
extension ProfileRegisterView {
    
    var content: some View {
        ZStack {
            
            self.profileContentView
            
            self.signToolBar
            
            .navigationBarHidden(true)
        }
    }
    
    var profileContentView: some View {
        VStack {
            Spacer()
            URLImageView(urlString: "https://search.pstatic.net/common/?src=http%3A%2F%2Fimgnews.naver.net%2Fimage%2F022%2F2020%2F08%2F14%2F20200814507231_20200814093806474.png&type=a340")
                .scaledToFill()
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 0.1))
                .shadow(radius: 1)
                .frame(width: 150, height: 150)
            
            Text("프로필")
            Spacer()
        }
    }
    
    
    var signToolBar: some View {
        VStack(spacing: 0) {
            ZStack {
                self.toolBarTitle(title: "Profile Registration")
                
                self.toolBarButton
            }
            .padding(.vertical, 15)
            Spacer()
        }
    }
    
    var toolBarButton: some View {
        HStack{
            Button(action: {
                withAnimation {
                    presentation.wrappedValue.dismiss()
                }
            }) {
                Image(systemName: "arrow.left")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.black)
            }
            Spacer()
        }
        .padding(.leading, 30)
    }
    
    func toolBarTitle(title: String) -> some View {
        HStack {
            Spacer()
            
            Text(title)
                .font(.custom("NanumGothicBold", size: 22))
            
            Spacer()
        }
    }
}

struct ProfileRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileRegisterView(phoneNumber: "01075187260", school: "Dongguk University")
            .inject(AppEnvironment.bootstrap().container)
    }
}
