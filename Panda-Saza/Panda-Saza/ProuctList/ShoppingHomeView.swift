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
        VStack(spacing: 0){
            HStack {
                Spacer()
                NavigationLink(destination: SearchView()) {
                    Image(systemName: "magnifyingglass")
                }
                NavigationLink(destination: LikeView()) {
                    Image(systemName: "suit.heart")
                }
            }.padding(.trailing, 10)
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight / 20)
            .foregroundColor(.black)
            
            Divider()
            self.productThumbnailView(products: viewModel.products)
                .foregroundColor(.black)
        }
        
        .navigationBarHidden(true)
    }
}

extension ShoppingHomeView {
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
                
            
            }
            .navigationBarHidden(true)
    }
}
