//
//  SwiftUIView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/10.
//

import SwiftUI

struct SearchBar: View {
    
    let searchText: Binding<String>
    let hintText: String
    
    // UI References
    let height: CGFloat
    
    @State private var isEditing: Bool = false
    
    
    init(searchText: Binding<String> = .constant(""),
         hintText: String = "",
         height: CGFloat = 60
    ) {
        self.searchText = searchText
        self.hintText = hintText
        self.height = height
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                /// Search Bar Layer
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 20, height: 20)
                    
                    TextField(hintText,
                              text: searchText,
                              onEditingChanged: { _ in isEditing.toggle() },
                              onCommit: { isEditing.toggle() })
                        .font(.custom("NanumGothic", size: 22))
                        .foregroundColor(Color.black)
                        .background(Color.white.opacity(0.1))
                }
                /// Cancel Button Layer
                if isEditing {
                    HStack {
                        Spacer()
                        Image(systemName: "multiply")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .padding(5)
                    }
                }
            }
            .overlay(
                VStack{
                    Divider()
                        .frame(height:1)
                        .background(Color.black)
                        .offset(x: 0, y: 30)
                }
            )
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("top")
        SearchBar(hintText: "Search your school")
            .frame(height: 60)
            .padding(.horizontal, 50)
            Text("bottom")
        }
    }
}
