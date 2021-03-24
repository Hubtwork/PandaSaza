//
//  SwiftUIView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/17.
//

import SwiftUI

struct HateItemView: View {
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        layout
    }
}

extension HateItemView {
    
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
                    Text("아직 차단한 사용자가 없어요")
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
                Text("차단 목록")
                    .font(.title2)
                    .bold()
                Spacer()
            }.padding(.vertical, 10)
        }
    }
    
    
}

struct HateItemView_Previews: PreviewProvider {
    static var previews: some View {
        HateItemView()
    }
}
