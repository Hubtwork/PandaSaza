//
//  ShoppingHomeView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/24.
//

import SwiftUI

struct ShoppingHomeView: View {
    
    var viewModel: ShoppingHomeViewModel
    
    var body: some View {
        ZStack {
            /// Layer 1 : item List
            VStack(spacing: 0){
                HStack(spacing: 15){
                    Spacer()
                    NavigationLink(destination: SearchView()) {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                    NavigationLink(destination: LikeView()) {
                        Image(systemName: "heart")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                }.padding(.trailing, 15)
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight / 20)
                .foregroundColor(.black)
                
                Divider()
                self.productThumbnailView(products: viewModel.products)
                    .foregroundColor(.black)
            }
            /// Layer 2 : Button
            self.registProductButton
            
        }
        .navigationBarHidden(true)
    }
}


extension ShoppingHomeView {
    
    var registProductButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                NavigationLink(destination:
                                ProductRegistView()
                                .navigationBarHidden(true)
                ) {
                    Text("판매글 등록")
                        .font(.body)
                        .foregroundColor(.black)
                        .bold()
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.blue.opacity(0.2)))
                }
                .padding([.trailing, .bottom], 15)
            }
        }
    }
    
    func productThumbnailView(products: [ProductThumbnail]) -> some View {
            ScrollView {
            LazyVGrid(columns: [
                GridItem(.fixed(UIScreen.screenWidth * 0.44), spacing: UIScreen.screenWidth * 0.04),
                GridItem(.fixed(UIScreen.screenWidth * 0.44))
            ], alignment: .center, spacing: UIScreen.screenWidth * 0.07, content: {
                ForEach(products, id: \.self) { product in
                    VStack(alignment: .leading) {
                        NavigationLink(destination: ProductDetailView(viewModel: ProductDetailViewModel(pId: product.itemId))
                                        .navigationBarHidden(true) ){
                            ProductThumbnailView(viewModel: ProductThumbnailViewModel(product: product))
                        }
                    }
                }
            })
            .padding(.top, UIScreen.screenWidth * 0.04)
                
            
            }
            .navigationBarHidden(true)
    }
}
