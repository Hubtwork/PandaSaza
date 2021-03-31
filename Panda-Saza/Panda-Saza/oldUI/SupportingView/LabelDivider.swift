//
//  LabelDivider.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/22.
//

import SwiftUI

struct LabelledDivider: View {

    let label: String
    let horizontalPadding: CGFloat
    let color: Color

    init(label: String, horizontalPadding: CGFloat = 20, color: Color = .gray) {
        self.label = label
        self.horizontalPadding = horizontalPadding
        self.color = color
    }

    var body: some View {
        HStack {
            line
            Text(label)
                .font(.custom("NanumGothicBold", size: 25))
                .foregroundColor(color)
            line
        }
    }

    var line: some View {
        VStack { Divider().frame(height: 2).background(color) }.padding(horizontalPadding)
    }
}
