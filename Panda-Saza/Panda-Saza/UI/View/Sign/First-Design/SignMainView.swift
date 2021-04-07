//
//  SignMainView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/06.
//

import SwiftUI

struct SignMainView: View {
    
    @Environment(\.injected) private var injected: DIContainer
    
    var body: some View {
        content
    }
}

extension SignMainView {
    
    var content: some View {
        ZStack {
            self.signMainBG
            
            self.signMainScreen
        }
    }
    
    
    var signMainBG: some View {
        BackgroundImageCarousel(imageStrings: ["bgEx1", "bgEx2", "bgEx3", "bgEx4"])
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
    }
    
    var signMainScreen: some View {
        VStack(spacing: 50) {
            SignLogoCell(logo: "PandaSaza")
                .padding(.bottom, 50)
            Button(action: {
                print("")
            }){
                RoundedButton(textColor: Color.white, bgColor: Color.black.opacity(0.25), height: 50, strokeColor: Color.white, text: "Sign Up")
            }
            
            DashDivider()
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                .frame(width: UIScreen.screenWidth * 0.75, height: 1)
                .background(Color.white)
            
            Button(action: {
                print("")
            }){
                RoundedButton(textColor: Color.white, bgColor: Color.black.opacity(0.25), height: 50, strokeColor: Color.white, text: "Sign In")
            }
            Text("Look around without Sign In")
                .font(.custom("NanumGothicBold", size: 22))
                .foregroundColor(Color.white)
                .overlay(
                    Rectangle().frame(height: 2)
                        .foregroundColor(Color.white)
                        .offset(y: 4)
                    , alignment: .bottom)
        }.transition(.move(edge: .top))
    }
}

struct SignMainView_Previews: PreviewProvider {
    static var previews: some View {
        SignMainView()
            .inject(AppEnvironment.bootstrap().container)
    }
}
