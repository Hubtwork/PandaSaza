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
    
    // UI Reference
    let textFieldHeight: CGFloat
    let width: CGFloat = 500
    
    init(text: Binding<String>,
         hint: String,
         infoNeeded: Binding<Bool> = .constant(false),
         info: Binding<String> = .constant("check the email"),
         textFieldHeight: CGFloat = 60
    ) {
        self.text = text
        self.hint = hint
        self.infoNeeded = infoNeeded
        self.info = info
        self.textFieldHeight = textFieldHeight
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            TextField(hint, text: text)
                .font(.custom("NanumGothic", size: 25))
                .padding(.horizontal, 15)
                .frame(height: textFieldHeight)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .overlay(
                  RoundedRectangle(cornerRadius: 5)
                    .stroke(infoNeeded.wrappedValue ? Color.red : Color.black,
                            lineWidth: infoNeeded.wrappedValue ? 2 : 1)
                )
            
            if infoNeeded.wrappedValue {
                Text(info.wrappedValue)
                    .font(.custom("NanumGothicBold", size: 18))
                    .foregroundColor(Color.red)
                    .padding(.leading, 10)
            }
        }
        .frame(width: .infinity)
        .animation(.easeInOut)

    }
}

struct HintTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("hi")
            HintTextField(text: .constant(""), hint: "write your email", infoNeeded: .constant(true))
                .frame(width: UIScreen.screenWidth*0.8)
            Text("end")
        }
    }
}
