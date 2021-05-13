//
//  TextfieldModifiers.swift
//  Panda-Saza
//
//  Created by 허재 on 2021/05/13.
//

import Foundation
import SwiftUI

struct RoundedCornerHStack: ViewModifier {
    var roundedCornes: CGFloat
    var textColor: Color
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.white)
            .cornerRadius(roundedCornes)
            .padding(3)
            .foregroundColor(textColor)
            .overlay(RoundedRectangle(cornerRadius: roundedCornes)
                        .stroke(Color.black, lineWidth: 1))
            .font(.custom("Open Sans", size: 15))
    }
}
