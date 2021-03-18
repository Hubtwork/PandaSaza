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

    var body: some View {
        ZStack(alignment: .leading) {
            Text(title)
                .foregroundColor(text.wrappedValue.isEmpty ? Color(.placeholderText) : Color(.blue))
                .offset(y: text.wrappedValue.isEmpty ? 0 : -25)
                .scaleEffect(text.wrappedValue.isEmpty ? 1 : 0.8, anchor: .leading)
            TextField("", text: text) // give TextField an empty placeholder
                .overlay(
                    VStack{
                        Divider()
                            .background(Color.blue)
                            .offset(x: 0, y: 15)
                    }
                )
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
            FloatingTextField(title: "Password", text: $pw)
        }.padding()
    }
}

struct FloatingTextField_Previews: PreviewProvider {
    static var previews: some View {
        LoginForm()
    }
}
