//
//  SignMain.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/30.
//

import SwiftUI

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

struct SignMain: View {
    
    
    @Environment(\.injected) private var injected: DIContainer
    
    @State private var viewState = SignViewState.main
    
    @State private var signInEmail: String = ""
    @State private var signInPassword: String = ""
    
    @State private var signUpEmail: String = ""
    @State private var signUpName: String = ""
    @State private var signUpPassword: String = ""
    @State private var signUpPasswordCheck: String = ""
    @State private var signUpPhone: String = ""
    @State private var signUpSchool: String = "CHOOSE >"
    
    @State private var signUpAgreeAll: Bool = false
    @State private var signUpAgreeUsage: Bool = false
    @State private var signUpAgreePersonal: Bool = false
    @State private var signUpAgreeEventNotice: Bool = false
    
    let fontName: String = "NanumGothic"
    
    var body: some View {
        content
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
    
    var content: some View {
            ZStack {
                switch self.viewState {
                case .main:
                    self.signMainBG
                    self.signMainScreen
                case .signIn:
                    self.signInBG
                    self.signInScreen
                case .signUp:
                    self.signUpBG
                    VStack {
                        self.signUpToolBar
                            .padding(.top, 60)
                            .padding(.leading, 30)
                        ScrollView {
                            VStack{}.frame(height: UIScreen.screenHeight * 0.05)
                            self.signUpScreen
                        }
                    }
                }
                
            }
            .ignoresSafeArea()
    }
}

// MARK: - Displaying Contents

private extension SignMain {
    var signMainBG: some View {
        BackgroundImageCarousel(imageStrings: ["bgEx1", "bgEx2", "bgEx3", "bgEx4"])
            .frame(width: .infinity, height: .infinity)
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
                FloatingTextField(title: "Email", text: $signInEmail, underbarColor:  Color.white, textColor: Color.white, hintColor: Color.white, fontSize: 20)
                
                FloatingTextField(title: "Password", text: $signInPassword, underbarColor:  Color.white, textColor: Color.white, hintColor: Color.white, fontSize: 20)
            }.frame(width: UIScreen.screenWidth * 0.8)
            
            RoundedButton(textColor: Color.white, bgColor: Color.black.opacity(0.2), height: 50, strokeColor: Color.white, text: "Sign In")
            
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
        .onAppear {
            self.signInEmail = ""
            self.signInPassword = ""
        }
    }
    
    var signUpScreen: some View {
        VStack(alignment: .leading, spacing: 20) {
            FloatingTextField(title: "Email", text: $signUpEmail, underbarColor:  Color.white, textColor: Color.white, hintColor: Color.white, fontSize: 18)
            
            FloatingTextField(title: "Name", text: $signUpName, underbarColor:  Color.white, textColor: Color.white, hintColor: Color.white, fontSize: 18)
            
            FloatingTextField(title: "Password ( over 8 characters )", text: $signUpPassword, underbarColor:  Color.white, textColor: Color.white, hintColor: Color.white, fontSize: 18)
            
            FloatingTextField(title: "Password Check", text: $signUpPasswordCheck, underbarColor:  Color.white, textColor: Color.white, hintColor: Color.white, fontSize: 18)
            
            FloatingTextField(title: "Phone", text: $signUpPhone, underbarColor:  Color.white, textColor: Color.white, hintColor: Color.white, fontSize: 18)
            
            HStack {
                Text("School")
                    .font(.custom("NanumGothicBold", size: 20))
                    .foregroundColor(.white)
                Spacer()
                Text(signUpSchool)
                    .font(.custom("NanumGothicBold", size: 20))
                    .foregroundColor(.white)
            }.padding(.top, 20)
            
            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    Image(systemName: signUpAgreeAll ? "checkmark.square": "square")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.white)
                    
                    Text("Agree all")
                        .font(.custom("NanumGothicBold", size: 22))
                        .foregroundColor(.white)
                    
                    Spacer()
                }.padding(.leading, 5)
                
                Divider()
                    .frame(height:2)
                    .background(Color.white)
                
                HStack(spacing: 10) {
                    Image(systemName: signUpAgreeUsage ? "checkmark.square": "square")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.white)
                    
                    Text("(Required) Terms Of Use")
                        .font(.custom("NanumGothicBold", size: 18))
                        .foregroundColor(.white)
                    Spacer()
                }.padding(.leading, 10)
                
                HStack(spacing: 10) {
                    Image(systemName: signUpAgreePersonal ? "checkmark.square": "square")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.white)
                    
                    Text("(Required) Privacy Policy")
                        .font(.custom("NanumGothicBold", size: 18))
                        .foregroundColor(.white)
                    Spacer()
                }.padding(.leading, 10)
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack(spacing: 10) {
                        Image(systemName: signUpAgreeEventNotice ? "checkmark.square": "square")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color.white)
                        
                        Text("(Choice) Event Notification")
                            .font(.custom("NanumGothicBold", size: 18))
                            .foregroundColor(.white)
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
            
        RoundedButton(textColor: Color.white, bgColor: Color.black.opacity(0.2), height: 50, strokeColor: Color.white, text: "Sign Up")
            .padding(.top, 20)
            
        }.frame(width:UIScreen.screenWidth * 0.8)
        .transition(.move(edge:.top))
        .onAppear {
            self.signUpName = ""
            self.signUpEmail = ""
            self.signUpPassword = ""
            self.signUpPasswordCheck = ""
            self.signUpPhone = ""
            self.signUpSchool = ""
            
            self.signUpAgreeAll = false
            self.signUpAgreeUsage = false
            self.signUpAgreePersonal = false
            self.signUpAgreeEventNotice = false
        }
    }
    
    var signUpToolBar: some View {
        HStack{
            Button(action: {
                self.viewState = .main
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

struct SignMain_Previews: PreviewProvider {
    static var previews: some View {
        SignMain().inject(AppEnvironment.bootstrap().container).previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
            .previewDisplayName("iPhone 12 Pro Max")
    }
}
