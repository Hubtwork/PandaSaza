//
//  SignMain.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/30.
//

import SwiftUI
import Combine

struct SignMain: View {
    
    @Environment(\.injected) private var injected: DIContainer
    
    @State private var signedUser: Loadable<UserModel> = .notRequested
    
    @State private var viewState = SignViewState.signIn
    
    @ObservedObject private var signUpValidation: SignUpValidation = SignUpValidation()
    @State private var signUpAgreeAll: Bool = false
    @State private var showSignUpAlert: Bool = false
    @State private var signUpAlertMessage: String = ""
    
    @ObservedObject private var signInValidation: SignInValidation = SignInValidation()
    @State private var showSignInAlert: Bool = false
    @State private var signInAlertMessage: String = ""
    @State private var showSignInError: Bool = false
    
    let fontName: String = "NanumGothic"
    
    var body: some View {
        signView
    }
}

// MARK: - SignViewState
private extension SignMain {
    enum SignViewState {
        case main
        case signIn
        case signUp
    }
}

private extension SignMain {
    
    var signView: some View {
        NavigationView {
            ZStack {
                switch self.viewState {
                case .main:
                    self.signMainBG
                    self.signMainScreen
                case .signIn:
                    self.signInBG
                    VStack {
                        self.signToolBar
                            .padding(.top, 60)
                            .padding(.leading, 30)
                        Spacer()
                    }
                    self.signInScreen
                    self.signing
                case .signUp:
                    self.signUpBG
                    VStack {
                        self.signToolBar
                            .padding(.top, 60)
                            .padding(.leading, 30)
                        ScrollView {
                            VStack{}.frame(height: 30)
                            self.signUpScreen
                        }
                    }
                    self.signing
                }
            }.ignoresSafeArea()
            
            .navigationBarHidden(true)
        }
        .onReceive(signInUpdate) { self.signedUser = $0 }
        .alert(isPresented: $showSignUpAlert, content: { self.signUpAlert })
        .alert(isPresented: $showSignInAlert, content: { self.signInAlert })
    }
}

// MARK: - Displaying Contents

private extension SignMain {
    var signMainBG: some View {
        BackgroundImageCarousel(imageStrings: ["bgEx1", "bgEx2", "bgEx3", "bgEx4"])
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
    }
    
    var signInBG: some View {
        Image("bgEx2")
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.screenWidth+20, height: UIScreen.screenHeight)
            .clipped()
            .blur(radius: 10)
    }
    
    var signUpBG: some View {
        Image("bgEx2")
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.screenWidth+20, height: UIScreen.screenHeight)
            .clipped()
            .blur(radius: 10)
    }
    
    var signMainScreen: some View {
        VStack(spacing: 50) {
            SignLogoCell(logo: "PandaSaza")
                .padding(.bottom, 50)
            Button(action: {
                withAnimation {
                    self.viewState = .signUp
                }
            }){
                RoundedButton(textColor: Color.white, bgColor: Color.black.opacity(0.2), height: 50, strokeColor: Color.white, text: "Sign Up")
            }
            
            DashDivider()
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                .frame(width: UIScreen.screenWidth * 0.5, height: 1)
            
            Button(action: {
                withAnimation {
                    self.viewState = .signIn
                }
            }){
                RoundedButton(textColor: Color.white, bgColor: Color.black.opacity(0.2), height: 50, strokeColor: Color.white, text: "Sign In")
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
    
    var signInScreen: some View {
        VStack(spacing: 50) {
            
            VStack(spacing: 30) {
                FloatingTextField(title: "Email", text: $signInValidation.email, underbarColor:  Color.white, textColor: Color.white, hintColor: Color.white, fontSize: 20)
                
                FloatingTextField(title: "Password", text: $signInValidation.password, underbarColor:  Color.white, textColor: Color.white, hintColor: Color.white, fontSize: 20)
            }.frame(width: UIScreen.screenWidth * 0.8)
            Button(action: {
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
                    signUpValidation.clearAll()
                    self.viewState = .signUp
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
    
    var signUpScreen: some View {
        VStack(alignment: .leading, spacing: 20) {
            FloatingTextField(title: "Email", text: $signUpValidation.email, underbarColor:  Color.white, textColor: Color.white, hintColor: Color.white, fontSize: 18)
            
            FloatingTextField(title: "Name", text: $signUpValidation.name, underbarColor:  Color.white, textColor: Color.white, hintColor: Color.white, fontSize: 18)
            
            FloatingTextField(title: "Password ( over 8 characters )", text: $signUpValidation.password, underbarColor:  Color.white, textColor: Color.white, hintColor: Color.white, fontSize: 18, isPassword: true)
            
            FloatingTextField(title: "Password Check", text: $signUpValidation.passwordCheck, underbarColor:  Color.white, textColor: Color.white, hintColor: Color.white, fontSize: 18, isPassword: true)
            
            FloatingTextField(title: "Phone", text: $signUpValidation.phone, underbarColor:  Color.white, textColor: Color.white, hintColor: Color.white, fontSize: 18)
            
            HStack {
                Text("School")
                    .font(.custom("NanumGothicBold", size: 20))
                    .foregroundColor(.white)
                Spacer()
                Text($signUpValidation.school.wrappedValue)
                    .font(.custom("NanumGothicBold", size: 20))
                    .foregroundColor(.white)
            }.padding(.vertical, 20)
            
            // MARK:- Policies Box Screening
            
            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    Button (action: {
                        signUpAgreeAll.toggle()
                        signUpValidation.agreeAll(state: signUpAgreeAll)
                    }) {
                    Image(systemName: signUpAgreeAll ? "checkmark.square": "square")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.white)
                    
                    Text("Agree all")
                        .font(.custom("NanumGothicBold", size: 22))
                        .foregroundColor(.white)
                    }
                    Spacer()
                }.padding(.leading, 5)
                
                Divider()
                    .frame(height:2)
                    .background(Color.white)
                
                HStack(spacing: 10) {
                    Button(action: {
                        signUpValidation.agreeUsage.toggle()
                    }) {
                    Image(systemName: $signUpValidation.agreeUsage.wrappedValue ? "checkmark.square": "square")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.white)
                    
                    Text("(Required) Terms Of Use")
                        .font(.custom("NanumGothicBold", size: 18))
                        .foregroundColor(.white)
                    }
                    Spacer()
                }.padding(.leading, 10)
                
                HStack(spacing: 10) {
                    Button(action: {
                        signUpValidation.agreePersonal.toggle()
                    }) {
                    Image(systemName: $signUpValidation.agreePersonal.wrappedValue ? "checkmark.square": "square")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.white)
                    
                    Text("(Required) Privacy Policy")
                        .font(.custom("NanumGothicBold", size: 18))
                        .foregroundColor(.white)
                    }
                    Spacer()
                }.padding(.leading, 10)
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack(spacing: 10) {
                        Button(action: {
                            signUpValidation.agreeEventNotice.toggle()
                        }) {
                        Image(systemName: $signUpValidation.agreeEventNotice.wrappedValue ? "checkmark.square": "square")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color.white)
                        
                        Text("(Choice) Event Notification")
                            .font(.custom("NanumGothicBold", size: 18))
                            .foregroundColor(.white)
                        }
                        Spacer()
                    }
                    
                    Text("You can receive event notification by email")
                        .font(.custom("NanumGothicBold", size: 14))
                        .foregroundColor(.white)
                }.padding(.leading, 10)
                
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .border(Color.white, width: 1)
            
            Text("Only college student can use it")
                .font(.custom("NanumGothicBold", size: 18))
                .foregroundColor(.white)
                .padding(.top, -10)
            
            Button(action: {
                validateSignUp()
            } ) {
                RoundedButton(textColor: Color.white, bgColor: Color.black.opacity(0.2), height: 50, strokeColor: Color.white, text: "Sign Up")
                    .padding(.top, 20)
            }
            
        }.frame(width:UIScreen.screenWidth * 0.8)
        .transition(.move(edge:.top))
        .onAppear {
            signUpAgreeAll = false
        }
    }
    
    private var signing: AnyView {
        switch signedUser {
        case .notRequested: return AnyView(VStack{Text("NotYet")})
        case .isLoading(_, _): return AnyView(VStack{Text("Loading")})
        case .loaded(_): return AnyView(VStack{Text("Loaded")}.onAppear{ signedSuccess() })
        case .failed(_): return AnyView(VStack{Text("Failed")}.onAppear{ print("실패") })
        }
    }
    
    var signToolBar: some View {
        HStack{
            Button(action: {
                withAnimation {
                    self.viewState = .main
                }
            }) {
                Image(systemName: "multiply")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.white)
            }
            Spacer()
        }
    }
}


// MARK:- Validation

extension SignMain {
    
    var signInAlert: Alert {
        Alert(title: Text(""), message: Text(signInAlertMessage), dismissButton: .default(Text("CHECK")))
    }
    
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
    
    var signUpAlert: Alert {
        Alert(title: Text(""), message: Text(signUpAlertMessage), dismissButton: .default(Text("CHECK")))
    }
    
    func validateSignUp() {
        if !signUpValidation.isValid {
            signUpAlertMessage = getSignOutError()
            self.showSignUpAlert.toggle()
        } else {
            // SignUp Interaction
            print("SignUP!")
        }
    }
    
    func getSignOutError() -> String {
        /**
        print("Email Alert(\($signUpValidation.emailAlert.wrappedValue.count)) : \($signUpValidation.emailAlert.wrappedValue)")
        print("Name Alert(\($signUpValidation.nameAlert.wrappedValue.count)) : \($signUpValidation.nameAlert.wrappedValue)")
        print("password Alert(\($signUpValidation.passwordAlert.wrappedValue.count)) : \($signUpValidation.passwordAlert.wrappedValue)")
        print("school Alert(\($signUpValidation.schoolAlert.wrappedValue.count)) : \($signUpValidation.schoolAlert.wrappedValue)")
        print("agree Alert(\($signUpValidation.agreeAlert.wrappedValue.count)) : \($signUpValidation.agreeAlert.wrappedValue)")
        */
        if signUpValidation.emailAlert != "" { return signUpValidation.emailAlert }
        else if signUpValidation.nameAlert != "" { return signUpValidation.nameAlert }
        else if signUpValidation.passwordAlert != "" { return signUpValidation.passwordAlert }
        else if signUpValidation.schoolAlert != "" { return signUpValidation.schoolAlert }
        else if signUpValidation.agreeAlert != "" { return signUpValidation.agreeAlert }
        else { return "" }
    }
}

// MARK: - Side Effects

private extension SignMain {
    
    func signIn(id: String, pw: String) {
        injected.interactors.signInteractor.signIn(user: $signedUser, id: id, pw: pw)
    }
    
    func signedSuccess() {
        print("이거 넘어왓냐?")
        injected.appState[\.system.isSigned] = true
    }
    
}

// MARK: - State Updates

private extension SignMain {
    
    var signInUpdate: AnyPublisher<Loadable<UserModel>, Never> {
        injected.appState.updates(for: \.userData.userData)
    }
    
}
