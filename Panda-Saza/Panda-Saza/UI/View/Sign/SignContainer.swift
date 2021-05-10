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
                        
                        VStack {
                            self.logo
                        }.frame(width: geometry.size.width * 0.8, height: geometry.size.height*0.1)
                        .border(Color.black, width: 1)
                        
                        Spacer()
                        
                        VStack {
                            self.title
                        }.frame(width: geometry.size.width * 0.8, height: geometry.size.height*0.3)
                        .border(Color.black, width: 1)
                        
                        Spacer()
                        
                        VStack {
                            self.signMenu
                        }.frame(width: geometry.size.width * 0.9,
                                height: geometry.size.height*0.1)
                        .border(Color.black, width: 1)
                        
                    }
                    .padding(.vertical, geometry.size.height*0.1)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }.foregroundColor(Color.black)
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    var logo: some View {
        Text("App Name")
            .font(.custom("NanumGothicBold", size: 20))
    }
    
    var title: some View {
        VStack(spacing: 20) {
            Text("Introducing image, texts, etc.")
                .font(.system(size:15))
        }
    }
    
    var signMenu: some View {
        VStack(spacing: 20) {
            NavigationLink(destination: PhoneValidationView()) {
                RoundedButton(textColor: .black, bgColor: .white, height: 30, strokeColor: .black, strokeWidth: 1, radius: 5, text: "Start with Phone", textSize: 15)
            }
        }
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
