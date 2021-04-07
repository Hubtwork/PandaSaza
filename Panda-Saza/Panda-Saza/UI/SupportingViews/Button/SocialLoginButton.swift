//
//  SocialLoginButton.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/07.
//

import SwiftUI


struct SocialButton: ViewModifier {

    private let bgColor: Color
    private let textColor: Color
    
    init(bg: Color, text: Color) {
        self.bgColor = bg
        self.textColor = text
    }

    dynamic func body(content: Content) -> some View {
        content
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .foregroundColor(textColor)
            .background(bgColor)
            .cornerRadius(15)
    }
}

extension View {
    dynamic func kakaoStyle(enabled: @escaping () -> Bool = { true }) -> some View {
        ModifiedContent(content: self, modifier: SocialButton(bg: Color.yellow, text: Color.black))
    }

    dynamic func facebookStyle(enabled: @escaping () -> Bool = { true }) -> some View {
        ModifiedContent(content: self, modifier: SocialButton(bg: Color.blue, text: Color.white))
    }
}

struct SocialLoginButton: View {
    
    let height: CGFloat
    let type: SocialType
    
    let fontName: String = "NanumGothicBold"
    
    init(height: CGFloat = 50,
         type: SocialType
    ) {
        self.height = height
        self.type = type
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                switch self.type {
                case .kakao: self.kakao
                case .facebook: self.facebook
                case .google: self.google
                case .email: self.email
                }
            }.frame(width: geometry.size.width, height: height)
        }
    }
    
    var kakao: some View {
        Text("Start with KakaoTalk".localized(Locale.current))
            .font(.custom("NanumGothicBold", size: 20))
            .kakaoStyle()
    }
    
    var facebook: some View {
        Text("Start with Facebook".localized(Locale.current))
            .font(.custom("NanumGothicBold", size: 20))
            .facebookStyle()
    }
    
    var google: some View {
        Text("Start with Google+".localized(Locale.current))
            .font(.custom("NanumGothicBold", size: 20))
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .foregroundColor(Color.black)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay(
              RoundedRectangle(cornerRadius: 15)
                .stroke(Color.black, lineWidth: 1)
            )
    }
    
    var email: some View {
        
        Text("Start with Email".localized(Locale.current))
            .font(.custom("NanumGothicBold", size: 20))
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .foregroundColor(Color.black)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay(
              RoundedRectangle(cornerRadius: 15)
                .stroke(Color.black, lineWidth: 1)
            )
    }
}

extension SocialLoginButton {
    
    enum SocialType {
        case kakao
        case facebook
        case google
        case email
    }
}

struct SocialLoginButton_Previews: PreviewProvider {
    static var previews: some View {
        SocialLoginButton(type: .google).frame(width: 400)
    }
}
