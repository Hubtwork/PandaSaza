//
//  CategoryView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/01.
//

import SwiftUI

struct CategoryView: View {
    
    @ObservedObject var viewModel: CategoryViewModel
    @Environment(\.presentationMode) var presentation
    let text: Binding<String>
    
    init(viewModel: CategoryViewModel, text: Binding<String>) {
        self.viewModel = viewModel
        self.text = text
    }
    
    // @Binding var selectedCategory: String
    
    var body: some View {
        VStack(spacing: 0) {
            self.categoryTitle
            Divider()
            ScrollView{
                self.categoryItem
            }
        }
    }
}

extension CategoryView {
    var categoryItem: some View {
            ForEach(self.viewModel.category!.category, id: \.self) { categoryStr in
                VStack(spacing: 0) {
                    Button(action: {
                        text.wrappedValue = categoryStr
                        presentation.wrappedValue.dismiss()
                    } ) {
                        HStack {
                            if (self.text.wrappedValue == categoryStr) {
                                Text(categoryStr)
                                    .font(.body)
                                    .bold()
                                    .foregroundColor(.red)
                                Spacer()
                                Image(systemName: "chevron.down.circle")
                                    .foregroundColor(.red)
                            }
                            else {
                                Text(categoryStr)
                                    .font(.body)
                                    .bold()
                                    .foregroundColor(.black)
                                Spacer()
                            }
                        }.padding(.horizontal, 15)
                        .padding(.vertical, 10)
                    }
                    Divider()
                }
            }
    }
    
    var categoryTitle: some View {
        ZStack {
            HStack {
                Button(action: { presentation.wrappedValue.dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(Font.system(size: UIScreen.screenWidth / 15))
                }.foregroundColor(.black)
                Spacer()
            }.padding(.vertical, 10)
            .padding(.leading, 10)
            HStack {
                Spacer()
                Text("카테고리 선택")
                    .font(.title2)
                    .bold()
                Spacer()
            }.padding(.vertical, 10)
        }
    }
}
