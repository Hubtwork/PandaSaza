//
//  SignIn.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/05.
//

import SwiftUI
import Combine

struct SignIn: View {
    
    @Environment(\.injected) private var injected: DIContainer
    @Environment(\.presentationMode) var presentation
    
    @State private var user: Loadable<UserModel> = .notRequested
    
    @ObservedObject private var signInValidation: SignInValidation = SignInValidation()
    @State private var showSignInAlert: Bool = false
    @State private var signInAlertMessage: String = ""
    
    let fontName: String = "NanumGothic"
    
    var body: some View {
        content
            .onChange(of: user) {
                switch user {
                case .isLoading(_, _):
                    print("로딩중")
                    return
                case let .loaded(user):
                    print("로그인 성공")
                    print(user.userEmail)
                    self.signedSuccess()
                    return
                case .failed(_):
                    print("실패")
                    self.signInAlertMessage = "Login Failed"
                    self.showSignInAlert = true
                    return
                default:
                    print($0)
                }
            }
    }
}

extension SignIn {
    
    var content: some View {
        ZStack {
            /// Background
            self.signInBG
            /// SignInLayer
            self.signInScreen
            self.signToolBar
            /// loadingLayer
        }
        .alert(isPresented: $showSignInAlert, content: { self.signInAlert })
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
                        .foregroundColor(Color.white)
                }
                Spacer()
            }
            Spacer()
        }.padding([.leading, .top], 50)
    }
    
    var signInAlert: Alert {
        Alert(title: Text(""), message: Text(signInAlertMessage), dismissButton: .default(Text("CHECK")))
    }
    
    var signInLoadingView: some View {
        VStack {
            Text("Loading")
                .font(.custom(fontName, size: 18))
            ActivityIndicatorView().padding()
        }.frame(width: 200, height: 100)
         .background(Color.secondary.colorInvert())
         .foregroundColor(Color.primary)
         .cornerRadius(20)
    }
    
    var signInBG: some View {
        Image("bgEx2")
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.screenWidth+20, height: UIScreen.screenHeight)
            .clipped()
            .blur(radius: 10)
    }
    
    var signInScreen: some View {
        VStack(spacing: 50) {
            
            VStack(spacing: 30) {
                FloatingTextField(title: "Email", text: $signInValidation.email, underbarColor:  Color.white, textColor: Color.white, hintColor: Color.white, fontSize: 20)
                
                FloatingTextField(title: "Password", text: $signInValidation.password, underbarColor:  Color.white, textColor: Color.white, hintColor: Color.white, fontSize: 20)
            }.frame(width: UIScreen.screenWidth * 0.8)
            Button(action: {
                user = .notRequested
                self.validateSignIn()
            } ) {
                RoundedButton(textColor: Color.white, bgColor: Color.black.opacity(0.2), height: 50, strokeColor: Color.white, text: "Sign In")
            }
            
            LabelledDivider(label: "or", color: Color.white)
                .frame(width: UIScreen.screenWidth * 0.8)
            
            Text("Forgot Email / Password?")
                .font(.custom("NanumGothicBold", size: 18))
                .foregroundColor(Color.white)
                .overlay(
                    Rectangle().frame(height: 2)
                        .foregroundColor(Color.white)
                        .offset(y: 4)
                    , alignment: .bottom)
            Button(action: {
                withAnimation{
                    
                }
            }){
                Text("No Account? Create one")
                    .font(.custom("NanumGothicBold", size: 18))
                    .foregroundColor(Color.white)
                    .overlay(
                        Rectangle().frame(height: 2)
                            .foregroundColor(Color.white)
                            .offset(y: 4)
                        , alignment: .bottom)
            }
        }
        .transition(.move(edge:.bottom))
    }
}

// MARK: - Side Effects

private extension SignIn {
    
    func signIn(id: String, pw: String) {
        //injected.interactors.signInteractor.signIn(user: $user, id: id, pw: pw)
    }
    
    func signedSuccess() {
        injected.appState[\.system.isSigned] = true
    }
    
    var signInUpdate: AnyPublisher<Loadable<UserModel>, Never> {
        injected.appState.updates(for: \.userData.userData)
    }
    
}

extension SignIn {
    
    func validateSignIn() {
        if !signInValidation.isValid {
            signInAlertMessage = getSignInError()
            self.showSignInAlert.toggle()
        } else {
            // SignIn Interaction
            self.signIn(id: signInValidation.email, pw: signInValidation.password)
        }
    }
    
    func getSignInError() -> String {
        if signInValidation.emailAlert != "" { return signInValidation.emailAlert }
        else if signInValidation.passwordAlert != "" { return signInValidation.passwordAlert }
        else { return "" }
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn().inject(AppEnvironment.bootstrap().container)
    }
}

