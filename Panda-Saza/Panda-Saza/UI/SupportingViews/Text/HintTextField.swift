//
//  HintTextField.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/09.
//

import SwiftUI
import Combine

struct HintTextField: View {
    
    let text: Binding<String>
    let hint: String
    let infoNeeded: Binding<Bool>
    let info: Binding<String>
    let isNumber: Bool
    
    // UI References
    let textFieldHeight: CGFloat
    let width: CGFloat = 500
    @State private var isEditing: Bool = false
    
    init(text: Binding<String>,
         hint: String,
         infoNeeded: Binding<Bool> = .constant(false),
         info: Binding<String> = .constant(""),
         textFieldHeight: CGFloat = 55,
         isNumber: Bool = false
    ) {
        self.text = text
        self.hint = hint
        self.infoNeeded = infoNeeded
        self.info = info
        self.textFieldHeight = textFieldHeight
        self.isNumber = isNumber
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            TextField(hint,
                      text: text,
                      onEditingChanged: { _ in isEditing.toggle() },
                      onCommit: { isEditing.toggle() }
                      )
                .keyboardType(isNumber ? .numberPad : .default)
                .font(.custom("NanumGothic", size: 22))
                .padding(.horizontal, 18)
                .frame(height: textFieldHeight)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .overlay(
                  RoundedRectangle(cornerRadius: 5)
                    .stroke(infoNeeded.wrappedValue ? Color.red : (isEditing ? Color.black : Color.gray),
                            lineWidth: infoNeeded.wrappedValue ? 2 : 1)
                ).textContentType(isNumber ? .oneTimeCode : .none)
            
            if infoNeeded.wrappedValue {
                Text(info.wrappedValue)
                    .font(.custom("NanumGothicBold", size: 18))
                    .foregroundColor(Color.red)
                    .padding(.leading, 10)
            }
        }
        .animation(.easeInOut)

    }
}

struct HintTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("hi")
            HintTextField(text: .constant(""), hint: "write your email", infoNeeded: .constant(false))
                .frame(width: UIScreen.screenWidth*0.8)
            Text("end")
        }
    }
}
