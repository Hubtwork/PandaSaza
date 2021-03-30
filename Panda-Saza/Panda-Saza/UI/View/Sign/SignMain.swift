//
//  SignMain.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/30.
//

import SwiftUI

struct SignMain: View {
    
    
    @Environment(\.injected) private var injected: DIContainer
    
    let fontName: String = "NanumGothic-Regular"
    
    var body: some View {
        content
    }
}

private extension SignMain {
    
    var content: some View {
        NavigationView {
            ZStack {
                Spacer()
                    .frame(width: .infinity, height: .infinity)
                    .background(Color.pink.opacity(0.2))
                
                VStack(spacing: 30) {
                    SignLogoCell(logo: "PandaSaza")
                        .padding(.bottom, 50)
                    RoundedButton(height: 40, text: "Sign Up")
                    DashDivider()
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                        .frame(width: UIScreen.screenWidth * 0.8, height: 1)
                    RoundedButton(height: 40, text: "Sign In")
                }
            }.ignoresSafeArea()
            
            .navigationBarHidden(true)
        }
    }
}

struct SignMain_Previews: PreviewProvider {
    static var previews: some View {
        SignMain().inject(AppEnvironment.bootstrap().container)
    }
}
