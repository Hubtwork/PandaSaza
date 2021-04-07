//
//  SignIn_Email.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/07.
//

import SwiftUI
import Combine

struct SignIn_Email: View {
    
    
    @Environment(\.injected) private var injected: DIContainer
    @Environment(\.presentationMode) private var presentation
    
    @State private var user: Loadable<UserModel> = .notRequested
    
    @ObservedObject private var signInValidation: SignInValidation = SignInValidation()
    @State private var showSignInAlert: Bool = false
    @State private var signInAlertMessage: String = ""
    
    
    var body: some View {
        content
    }
}

// MARK: - Screens

private extension SignIn_Email {
    
    var content: some View {
        ZStack {
            
            self.signMenu
            
            self.signToolBar
            
            .navigationBarHidden(true)
        }
    }
    
    var signMenu: some View {
        VStack(spacing: 20) {
            // SignIn Inputs
            VStack(spacing: 30) {
                FloatingTextField(title: "Email", text: $signInValidation.email, underbarColor:  Color.black, textColor: Color.black, hintColor: Color.blue, fontSize: 22)
                
                FloatingTextField(title: "Password", text: $signInValidation.password, underbarColor:  Color.black, textColor: Color.black, hintColor: Color.blue, fontSize: 22)
                
                SocialLoginButton(height: 40, type: .email)
                    .frame(height: 40)
            }
            
            LabelledDivider(label: "or", color: Color.black)
            
            VStack(spacing: 30) {
                self.findAccountButton
                
                self.signUpButton
            }
            
        }.padding(.horizontal, 50)
    }
    
    var findAccountButton: some View {
        Text("Forgot Email / Password?")
            .font(.custom("NanumGothicBold", size: 18))
            .foregroundColor(Color.black)
            .overlay(
                Rectangle().frame(height: 2)
                    .foregroundColor(Color.black)
                    .offset(y: 5)
                , alignment: .bottom)
    }
    
    var signUpButton: some View {
        Text("No Account? Create one")
            .font(.custom("NanumGothicBold", size: 18))
            .foregroundColor(Color.black)
            .overlay(
                Rectangle().frame(height: 2)
                    .foregroundColor(Color.black)
                    .offset(y: 5)
                , alignment: .bottom)
    }
    
    var signToolBar: some View {
        VStack {
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
            Spacer()
        }
        .padding(.leading, 30)
        .padding(.top, 10)
    }
    
}

// MARK: - Side Effects

private extension SignIn_Email {
    
    func signIn(id: String, pw: String) {
        injected.interactors.signInteractor.signIn(user: $user, id: id, pw: pw)
    }
    
    func signedSuccess() {
        injected.appState[\.system.isSigned] = true
        injected.appState[\.system.activateContent] = true
    }
    
    var signInUpdate: AnyPublisher<Loadable<UserModel>, Never> {
        injected.appState.updates(for: \.userData.userData)
    }
    
}


struct SignIn_Email_Previews: PreviewProvider {
    static var previews: some View {
        SignIn_Email()
    }
}
