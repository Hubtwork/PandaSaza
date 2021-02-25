//
//  RoundedEdge.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/23.
//

import SwiftUI

struct RoundedEdge: ViewModifier {
    let width: CGFloat
    let color: Color
    let cornerRadius: CGFloat

    func body(content: Content) -> some View {
        content.cornerRadius(cornerRadius - width)
            .padding(width)
            .background(color)
            .cornerRadius(cornerRadius)
    }
}
