//
//  FloatingTextField.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/22.
//

import SwiftUI

struct FloatingTextField: View {
    let title: String
    let text: Binding<String>
    
    let underbarColor: Color
    let textColor: Color
    let hintTextColor: Color
    let fontSize: CGFloat
    
    let isPassword: Bool
    
    
    init(title: String, text: Binding<String>, underbarColor: Color = .blue, textColor: Color = .black, hintColor: Color = .black, fontSize:CGFloat = 20, isPassword: Bool = false) {
        self.title = title
        self.text = text
        self.underbarColor = underbarColor
        self.textColor = textColor
        self.hintTextColor = hintColor
        self.fontSize = fontSize
        self.isPassword = isPassword
    }

    var body: some View {
        ZStack(alignment: .leading) {
            Text(title)
                .font(.custom("NunumGothicBold", size: fontSize))
                .foregroundColor(text.wrappedValue.isEmpty ? textColor : hintTextColor)
                .offset(y: text.wrappedValue.isEmpty ? 0 : -(fontSize+5))
                .scaleEffect(text.wrappedValue.isEmpty ? 1 : 0.8, anchor: .leading)
            
            if !isPassword {
                // Input Area
                TextField("", text: text) // give TextField an empty placeholder
                    .font(.custom("NunumGothicBold", size: fontSize))
                    .foregroundColor(textColor)
                    .background(Color.black.opacity(0.1))
                    .overlay(
                        VStack{
                            Divider()
                                .frame(height:2)
                                .background(underbarColor)
                                .offset(x: 0, y: 20)
                        }
                    )
            }
            else {
                // How about SecureField Usage?
                // Input Area
                SecureField("", text: text) // give TextField an empty placeholder
                    .font(.custom("NunumGothicBold", size: fontSize))
                    .foregroundColor(textColor)
                    .background(Color.black.opacity(0.1))
                    .overlay(
                        VStack{
                            Divider()
                                .frame(height:2)
                                .background(underbarColor)
                                .offset(x: 0, y: 20)
                        }
                    )
            }
        }
        .padding(.top, 15)
        .animation(.spring(response: 0.25, dampingFraction: 0.5))
    }
}

struct LoginForm: View {
    @State var id: String = ""
    @State var pw: String = ""
    var body: some View {
        VStack {
            FloatingTextField(title: "ID", text: $id)
            FloatingTextField(title: "Password", text: $pw, isPassword: true)
        }.padding()
    }
}

struct FloatingTextField_Previews: PreviewProvider {
    static var previews: some View {
        LoginForm()
    }
}
