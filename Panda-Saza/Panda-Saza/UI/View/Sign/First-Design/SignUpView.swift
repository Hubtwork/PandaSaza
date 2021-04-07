//
//  SignUpView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/06.
//

import SwiftUI

struct SignUp: View {
    
    @Environment(\.injected) private var injected: DIContainer
    @Environment(\.presentationMode) private var presentation
    
    @ObservedObject private var signUpValidation: SignUpValidation = SignUpValidation()
    @State private var signUpAgreeAll: Bool = false
    @State private var showSignUpAlert: Bool = false
    @State private var signUpAlertMessage: String = ""
    
    var body: some View {
        content
    }
}

extension SignUp {
    
    var content: some View {
        ZStack {
            self.signUpBG
            
            self.signToolBar
        }
    }
    
    var signUpBG: some View {
        Image("bgEx3")
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
            .clipped()
            .blur(radius: 10)
            .opacity(0.5)
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
        }.padding([.leading, .top], 50)
    }
    
    
}

// MARK:- Side Effect

extension SignUp {
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUp().inject(AppEnvironment.bootstrap().container)
    }
}
