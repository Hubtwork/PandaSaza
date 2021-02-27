//
//  ProductThumbnail.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/26.
//

import SwiftUI

struct ProductThumbnailView: View {
    var viewModel: ProductThumbnailViewModel
    
        
    var body: some View {
        VStack(alignment: .leading, spacing: UIScreen.screenWidth * 0.02){
            ImageView(withURL: viewModel.product.thumbnailImageURL, isComingFromHomepage: false)
                .frame(height: UIScreen.screenWidth * 0.4)
                .background(Color(.white))
            HStack {
                Text("(Trans) " + viewModel.product.itemNameTrans)
                .font(.caption)
                .bold()
                Spacer()
            }.frame(minWidth: 0, maxWidth: .infinity)
            .padding(.leading, UIScreen.screenWidth * 0.02)
            HStack {
                Text(viewModel.product.itemName)
                    .font(.caption)
                    .bold()
                Spacer()
            }.frame(minWidth: 0, maxWidth: .infinity)
            .padding(.leading, UIScreen.screenWidth * 0.02)
            HStack {
                Text(viewModel.product.sellerLoc + " • " + calcDateDiff(baseDateTimestamp: viewModel.product.registrationTime))
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .bold()
                Spacer()
            }.frame(minWidth: 0, maxWidth: .infinity)
            .padding(.leading, UIScreen.screenWidth * 0.02)
            
            HStack {
                HStack(spacing: 3) {
                    if (viewModel.product.cnt_chat > 0) {
                        Image("chat")
                            .resizable()
                            .frame(width: 10, height: 10)
                        Text(String(viewModel.product.cnt_chat))
                            .font(.caption2)
                    }
                }.frame(width: 20)
                HStack(spacing: 3) {
                    if (viewModel.product.cnt_like > 0) {
                        Image("heart")
                            .resizable()
                            .frame(width: 10, height: 10)
                        Text(String(viewModel.product.cnt_like))
                            .font(.caption2)
                    }
                }.frame(width: 20)
                Spacer()
                Text(String(format: "%d %@", viewModel.product.itemPrice, "원"))
                    .font(.caption)
                    .bold()
            }.frame(minWidth: 0, maxWidth: .infinity)
            .padding(.leading, UIScreen.screenWidth * 0.02)
            .padding([.trailing, .bottom], UIScreen.screenWidth * 0.02)
        }
        .background(Color.white)
        .modifier(ProductFrameEdge(width: 0.5, color: .gray))
    }
}
