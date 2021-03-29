//
//  ProductCell.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/28.
//

import SwiftUI
import URLImage

struct ProductCell: View {
    
    let product: Product
    let cellWidth: CGFloat
    let fgColor: Color = .black
    
    let fontName: String = "NanumGothic-Regular"
    
    var body: some View {
        self.content
    }
}

extension ProductCell {
    var content: some View {
        VStack(alignment: .leading, spacing: 5){
            /// Item Thumbnail Image Stack
            URLImageView(urlString: product.thumbnailImageURL)
                .frame(width: cellWidth, height: cellWidth)
                .background(Color.white)
            /// Item Name Stack
            HStack {
                Text(product.itemNameTrans)
                    .font(.custom(fontName, size: 15))
                    .bold()
                    .lineLimit(1)
                Spacer()
            }.frame(minWidth: 0, maxWidth: cellWidth-10)
            .padding(.horizontal, 5)
            HStack {
                Text(product.itemName)
                    .font(.custom(fontName, size: 13))
                    .bold()
                    .lineLimit(1)
                Spacer()
            }.frame(minWidth: 0, maxWidth: cellWidth-10)
            .padding(.horizontal, 5)
            /// Item Location / RegistTime Stack
            HStack {
                Text(product.sellerLoc + " • " + calcDateDiff(baseDateTimestamp: product.registrationTime))
                    .foregroundColor(.gray)
                    .bold()
                Spacer()
            }.frame(minWidth: 0, maxWidth: .infinity)
            .padding(.horizontal, 5)
            .font(.custom(fontName, size: 11))
            
            /// Item Chat / Like / Price Stack
            HStack(spacing: 10) {
                Spacer()
                if (product.cnt_chat > 0) {
                    HStack(spacing: 5) {
                        Image("chat")
                            .resizable()
                            .frame(width: 13, height: 13)
                        Text(String(product.cnt_chat))
                    }
                }
                if (product.cnt_like > 0) {
                    HStack(spacing: 5) {
                        Image("heart")
                            .resizable()
                            .frame(width: 13, height: 13)
                        Text(String(product.cnt_like))
                    }
                }
            }.frame(minWidth: 0, maxWidth: .infinity)
            .padding(.horizontal, 5)
            .font(.custom(fontName, size: 13))
            
            HStack {
                Spacer()
                Text(String(format: "%d %@", product.itemPrice, "원"))
                    .font(.custom(fontName, size: 15))
                    .bold()
            }.frame(minWidth: 0, maxWidth: .infinity)
            .padding(.horizontal, 5)
            .padding(.bottom, 5)
        }
        .foregroundColor(fgColor)
        .background(Color.white)
        .modifier(ProductFrameEdge(width: 0.5, color: .gray))
        .frame(width: cellWidth)
        
    }
}

struct ProductCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductCell(product: Product(itemId: 2, thumbnailImageURL: "https://cdn.allets.com/commerce/goods/resize/900/20210122/1611304143038_%EC%8D%B8%EB%84%A4%EC%9D%BC.jpg", itemCategory: "여성의류", itemName: "한복", itemNameTrans: "Korean Clothes", itemPrice: 34000, registrationTime: 1614124326.0, sellerLoc: "서강대학교", cnt_chat: 0, cnt_like: 4), cellWidth: UIScreen.screenWidth * 0.47)
    }
}
