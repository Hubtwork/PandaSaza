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
    
    @State private var isEditing: Bool = false
    
    
    init(searchText: Binding<String> = .constant(""),
         hintText: String = ""
    ) {
        self.searchText = searchText
        self.hintText = hintText
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                /// Search Bar Layer
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 15, height: 15)
                    ZStack {
                        if searchText.wrappedValue.isEmpty {
                            HStack {
                                Text(hintText)
                                    .font(.system(size: 15))
                                    .foregroundColor(Color.black.opacity(0.7))
                                Spacer()
                            }
                        }
                        TextField("",
                                  text: searchText,
                                  onEditingChanged: { _ in isEditing.toggle() },
                                  onCommit: { isEditing.toggle() })
                            .font(.custom("NanumGothic", size: 15))
                            .foregroundColor(Color.black)
                            .background(Color.white.opacity(0.1))
                    }
                }
                /// Cancel Button Layer
                if isEditing {
                    HStack {
                        Spacer()
                        Button(action: {
                            searchText.wrappedValue = ""
                        }) {
                            Image(systemName: "multiply")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .padding(5)
                        }.foregroundColor(.black)
                    }
                }
            }
            .overlay(
                VStack{
                    Divider()
                        .frame(height:1)
                        .background(Color.black)
                        .offset(x: 0, y: 15)
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
            .frame(height: 30)
            .padding(.horizontal, 50)
            Text("bottom")
        }
    }
}
