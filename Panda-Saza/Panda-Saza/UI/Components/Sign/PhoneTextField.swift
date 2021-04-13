//
//  PhoneTextField.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/13.
//

import SwiftUI
import Combine

struct PhoneTextField: View {
    
    let text: Binding<String>
    let hint: String
    let isAuthCode: Bool
    
    // UI References
    let textFieldHeight: CGFloat
    let width: CGFloat = 500
    @State private var isEditing: Bool = false
    
    init(text: Binding<String>,
         hint: String,
         textFieldHeight: CGFloat = 45,
         isAuth: Bool = false
    ) {
        self.text = text
        self.hint = hint
        self.textFieldHeight = textFieldHeight
        self.isAuthCode = isAuth
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            TextField(hint,
                      text: text,
                      onEditingChanged: { _ in isEditing.toggle() },
                      onCommit: { isEditing.toggle() }
                      )
            .textContentType(isAuthCode ? .oneTimeCode : .telephoneNumber)
            .keyboardType(.numberPad)
            .font(.custom("NanumGothic", size: 18))
            .padding(.horizontal, 18)
            .frame(height: textFieldHeight)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .overlay(
              RoundedRectangle(cornerRadius: 5)
                .stroke(isEditing ? Color.black : Color.gray,
                        lineWidth: 1)
            )
            
        }
        .animation(.easeInOut)

    }
}
