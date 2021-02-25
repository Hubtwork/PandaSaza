//
//  ScaledFont.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/24.
//

import SwiftUI

struct ScaledFont: ViewModifier {
    // From the article:
    // Asks the system to provide the current size category from the
    // environment, which determines what level Dynamic Type is set to.
    // The trick is that we don’t actually use it – we don’t care what the
    // Dynamic Type setting is, but by asking the system to update us when
    // it changes our UIFontMetrics code will be run at the same time,
    // causing our font to scale correctly.
    @Environment(\.sizeCategory) var sizeCategory
    var size: CGFloat
    
    func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.system(size: scaledSize))
    }
}
