//
//  SearchView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/24.
//

import SwiftUI

struct SearchBarView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var searchText: String
    @State private var showCancelButton: Bool = false
    var onCommit: () ->Void = {print("onCommit")}
    
    var body: some View {
        HStack {
            
            Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                Image(systemName: "chevron.left")
                    .font(Font.system(size: 20))
            }.foregroundColor(.black)
            .padding(.leading, 10)
            
            HStack {
                Image(systemName: "magnifyingglass")
                
                // Search text field
                ZStack (alignment: .leading) {
                    if searchText.isEmpty {
                        Text("검색어를 입력해주세요")
                    }
                    TextField("", text: $searchText, onEditingChanged: { isEditing in
                        self.showCancelButton = true
                    }, onCommit: onCommit).foregroundColor(.primary)
                }
            }
            .padding(EdgeInsets(top: 3, leading: 6, bottom: 3, trailing: 6))
            .foregroundColor(.gray)
            .background(Color(.tertiarySystemFill))
            .cornerRadius(10.0)
            
            if showCancelButton  {
                // Cancel button
                Button("취소") {
                    UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                    self.searchText = ""
                    self.showCancelButton = false
                }
                .padding(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 0))
                .foregroundColor(Color(.black))
            }
        }
        .padding(.trailing, 10)
        
        .navigationBarHidden(showCancelButton)
    }
}

struct SearchView: View {
    
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            /// Search View
            SearchBarView(searchText: $searchText)
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight / 20)
            
            Spacer()
        }
        
        .navigationBarHidden(true)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
