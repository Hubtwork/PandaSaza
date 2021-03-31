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
                    BackgroundImageCarousel(imageStrings: ["bgEx1", "bgEx2", "bgEx3", "bgEx4"])
                        .frame(width: .infinity, height: .infinity)
                    self.signMainScreen
                }
                
            }.ignoresSafeArea()
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
            .blur(radius: 5)
    }
    
    var signMainScreen: some View {
        VStack(spacing: 50) {
            SignLogoCell(logo: "PandaSaza")
                .padding(.bottom, 50)
            RoundedButton(textColor: Color.white, bgColor: Color.black.opacity(0.2), height: 50, strokeColor: Color.white, text: "Sign Up")
            
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
                FloatingTextField(title: "Email", text: $signInEmail, underbarColor:  Color.white, textColor: Color.white, hintColor: Color.white, fontSize: 30)
                
                FloatingTextField(title: "Password", text: $signInPassword, underbarColor:  Color.white, textColor: Color.white, hintColor: Color.white, fontSize: 30)
            }.frame(width: UIScreen.screenWidth * 0.8)
            
            RoundedButton(textColor: Color.white, bgColor: Color.black.opacity(0.2), height: 50, strokeColor: Color.white, text: "Sign In")
            
            LabelledDivider(label: "or", color: Color.white)
                .frame(width: UIScreen.screenWidth * 0.8)
            
            Text("Forgot Email / Password?")
                .font(.custom("NanumGothicBold", size: 22))
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
                    .font(.custom("NanumGothicBold", size: 22))
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
}

struct SignMain_Previews: PreviewProvider {
    static var previews: some View {
        SignMain().inject(AppEnvironment.bootstrap().container).previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
            .previewDisplayName("iPhone 12 Pro Max")
    }
}
