//
//  SignLogoCell.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/30.
//

import SwiftUI

struct SignLogoCell: View {
    
    let width: CGFloat
    let height: CGFloat
    let fg: Color
    let bg: Color
    
    // Texts
    let logo: String
    
    let fontName: String = "NanumGothic-Regular"
    
    init(width: CGFloat = UIScreen.screenWidth * 0.8,
         height: CGFloat = 200,
         fg: Color = .gray,
         bg: Color = .white,
         logo: String
    ) {
        self.fg = fg
        self.bg = bg
        self.width = width
        self.height = height
        self.logo = logo
    }
    
    var body: some View {
        VStack(spacing: 10) {
            // Logo Frame
            VStack {
                Text("Logo Frame")
            }.frame(width: 100, height: 50)
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            VStack(spacing: 0) {
                Text(logo)
                    .font(.custom(fontName, size: 18))
                    .foregroundColor(Color.black.opacity(0.6))
                
                Text("Used-Stuff Trading Partner")
                    .font(.custom(fontName, size: 15))
                    .foregroundColor(Color.black.opacity(0.6))
            }
            VStack(spacing: 5) {
                Text("Purchase for Efficient Life")
                    .font(.custom(fontName, size: 18))
                Text("Sell for Wealthy Life")
                    .font(.custom(fontName, size: 18))
            }
        }
        .frame(width: width, height: height)
        .cornerRadius(25)
        .background(bg.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct SignLogoCell_Previews: PreviewProvider {
    static var previews: some View {
        SignLogoCell(logo: "PandaSaza")
    }
}
