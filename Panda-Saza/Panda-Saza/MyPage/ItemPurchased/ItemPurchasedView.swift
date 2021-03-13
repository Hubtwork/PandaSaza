//
//  ItemPurchasedView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/11.
//

import SwiftUI

struct ItemPurchasedView: View {
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        layout
    }
}

extension ItemPurchasedView {
    
    var layout: some View {
        VStack(spacing: 0) {
            self.titleBar
            Divider()
            noItemView
        }
    }
    
    var noItemView : some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .center) {
                    Spacer()
                    Text("아직 구매한 상품이 없어요")
                        .font(.title2)
                        .foregroundColor(Color.black.opacity(0.6))
                    Spacer()
                }.frame(width: geometry.size.width,
                        height: geometry.size.height)
            }
        }
    }
    
    var titleBar: some View {
        ZStack {
            HStack {
                Button(action: { presentation.wrappedValue.dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(Font.system(size: UIScreen.screenWidth / 15))
                }.foregroundColor(.black)
                Spacer()
            }.padding(.vertical, 10)
            .padding(.horizontal, 10)
            
            HStack {
                Spacer()
                Text("구매내역")
                    .font(.title2)
                    .bold()
                Spacer()
            }.padding(.vertical, 10)
        }
    }
    
    
}

struct ItemPurchasedView_Previews: PreviewProvider {
    static var previews: some View {
        ItemPurchasedView()
    }
}
