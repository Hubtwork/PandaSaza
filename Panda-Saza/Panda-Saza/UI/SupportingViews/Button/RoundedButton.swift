//
//  RoundedButton.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/30.
//

import SwiftUI

struct RoundedButton: View {
    
    let color: Color
    let width: CGFloat
    let height: CGFloat
    let text: String
    
    let fontName: String = "NanumGothic-Regular"
    
    init(color: Color = .black,
         width: CGFloat = UIScreen.screenWidth * 0.8,
         height: CGFloat = 50,
         text: String
    ) {
        self.color = color
        self.width = width
        self.height = height
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.custom(fontName, size: 20))
            .bold()
            .padding()
            .frame(minWidth: 0, maxWidth: width, minHeight: 0, maxHeight: height, alignment: .center)
            .background(Color.white)
            .foregroundColor(color)
            .clipShape(RoundedRectangle(cornerRadius: 100))
            .overlay(
              RoundedRectangle(cornerRadius: 100)
                .stroke(Color.black, lineWidth: 2)
            )
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButton(text: "Example")
    }
}
