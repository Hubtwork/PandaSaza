//
//  ButtonStyle.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/22.
//

import SwiftUI

struct ButtonStyle: ViewModifier {

    private let color: Color
    private let enabled: () -> Bool
    
    init(color: Color, enabled: @escaping () -> Bool = { true }) {
        self.color = color
        self.enabled = enabled
    }

    dynamic func body(content: Content) -> some View {
        content
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .foregroundColor(Color.black)
            .background(enabled() ? color : Color.black)
            .cornerRadius(5)
    }
}

extension View {
    dynamic func buttonStyleThistle(enabled: @escaping () -> Bool = { true }) -> some View {
        ModifiedContent(content: self, modifier: ButtonStyle(color: Color.Thistle, enabled: enabled))
    }

    dynamic func buttonStyleCottenCandy(enabled: @escaping () -> Bool = { true }) -> some View {
        ModifiedContent(content: self, modifier: ButtonStyle(color: Color.CottenCandy, enabled: enabled))
    }

}
