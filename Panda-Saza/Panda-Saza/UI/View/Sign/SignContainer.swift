//
//  SignContainer.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/07.
//

import SwiftUI

struct SignNavMain: View {
    
    @Environment(\.injected) private var injected: DIContainer
    @Environment(\.presentationMode) private var presentation
    
    
    var body: some View {
        content
    }
}

extension SignNavMain {
    var content: some View {
        NavigationView {
            ZStack {
                
                
                GeometryReader { geometry in
                    VStack(alignment: .center, spacing: 0) {
                        self.logo
                            .padding(.top, geometry.size.height*0.1)
                        
                        self.title
                            .padding(.top, geometry.size.height*0.1)
                        
                        self.signMenu
                            .padding(.top, geometry.size.height*0.2)
                        
                        self.lookAroungBtn
                            .padding(.top, geometry.size.height*0.05)
                            .padding(.bottom, 70)
                    
                    }.frame(width: geometry.size.width, height: geometry.size.height)
                }
                self.signToolBar
            }.foregroundColor(Color.black)
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    var logo: some View {
        Text("PandaSaza")
            .font(.custom("NanumGothicBold", size: 44))
    }
    
    var title: some View {
        VStack(spacing: 20) {
            Text("Used-Stuff Trading Partner")
                .font(.custom("NanumGothicBold", size: 22))
            Text("Your efficient life Manager")
                .font(.custom("NanumGothic", size: 18))
                .foregroundColor(Color.black.opacity(0.8))
        }
    }
    
    var signMenu: some View {
        VStack(spacing: 20) {
            
            SocialLoginButton(height: 40, type: .facebook)
            
            SocialLoginButton(height: 40, type: .google)
            
            SocialLoginButton(height: 40, type: .kakao)
            
            NavigationLink(destination: PhoneValidationView()) {
                SocialLoginButton(height: 40, type: .phone)
            }
            
        }.frame(height: 220)
        .padding(.horizontal, 30)
    }
    
    var lookAroungBtn: some View {
        Button(action: {
            self.lookAroundWithoutSignIn()
        } ) {
            Text("Look around without Sign In")
                .font(.custom("NanumGothicBold", size: 16))
                .foregroundColor(Color.black)
                .overlay(
                    Rectangle().frame(height: 2)
                        .foregroundColor(Color.black)
                        .offset(y: 4)
                    , alignment: .bottom)
        }
    }
    
    var signToolBar: some View {
        VStack {
            HStack{
                Button(action: {
                    withAnimation {
                        presentation.wrappedValue.dismiss()
                    }
                }) {
                    Image(systemName: "multiply")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.black)
                }
                Spacer()
            }
            Spacer()
        }
        .padding(.leading, 30)
        .padding(.top, 10)
    }
}

// MARK:- Side Effect
private extension SignNavMain {
    
    func lookAroundWithoutSignIn() -> Void {
        injected.appState[\.system.activateContent] = true
    }
    
}

struct SignNavMain_Previews: PreviewProvider {
    static var previews: some View {
        SignNavMain()
            .inject(AppEnvironment.bootstrap().container)
    }
}
