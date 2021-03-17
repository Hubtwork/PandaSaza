//
//  ItemSaledView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/11.
//

import SwiftUI

struct ItemSaledView: View {
    
    @Environment(\.presentationMode) var presentation
    @State private var selectedTabIndex = 0
    
    var body: some View {
        layout
    }
}

extension ItemSaledView {
    
    var layout: some View {
        VStack(spacing: 3){
            SlidingTabView(selection: self.$selectedTabIndex,
                           tabs: ["판매중", "판매완료", "정산"],
                           font: Font.body.bold(),
                           activeAccentColor: Color.black,
                           selectionBarColor: Color.black)
            
            switch(selectedTabIndex) {
                case 0:
                    noItemView(ment: "판매중인 상품이 없습니다")
                case 1:
                    noItemView(ment: "판매완료된 상품이 없습니다")
                case 2:
                    noItemView(ment: "정산하 상품이 없습니다")
                default:
                    VStack{}
            }
        }
    }
    
    func noItemView(ment: String) -> some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .center) {
                    Spacer()
                    Text(ment)
                        .font(.title2)
                        .foregroundColor(Color.black.opacity(0.6))
                    Spacer()
                }.frame(width: geometry.size.width,
                        height: geometry.size.height)
            }
        }
    }
    
    
}

struct ItemSaledView_Previews: PreviewProvider {
    static var previews: some View {
        ItemSaledView()
    }
}
