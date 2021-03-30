//
//  LineSeparator.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/30.
//


import SwiftUI

struct LinePreview: View {
    var body: some View {
        VStack {
            DashDivider()
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                .frame(width: 50, height: 1)
        }
    }
}

struct DashDivider: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

struct LineSeparators_Previews: PreviewProvider {
    static var previews: some View {
        LinePreview()
    }
}
