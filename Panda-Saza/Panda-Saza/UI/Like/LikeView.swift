//
//  LikeView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/24.
//

import SwiftUI

struct LikeView: View {
    
    @State private var selectedTabIndex = 0
    
    var body: some View {
        
        layout
            .navigationBarHidden(true)
    }
    
}

extension LikeView {
    
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
                    Text("아직 찜한 상품이 없어요")
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
                Spacer()
                Text("찜 목록")
                    .font(.title3)
                    .bold()
                Spacer()
            }.padding(.vertical, 10)
        }
    }
}

struct LikeView_Previews: PreviewProvider {
    static var previews: some View {
        LikeView()
    }
}
