//
//  ItemDetailUserView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/25.
//

import SwiftUI

struct ProductDetailView: View {
    
    @ObservedObject var viewModel: ProductDetailViewModel
    @Environment(\.presentationMode) var presentation
    @State var index = 0
    
    var images = ["gucci_01", "gucci_02", "gucci_03"]

    var body: some View {
        productDetail
    }
}

private extension ProductDetailView {
    var productDetail: some View {
        /// Container
        ZStack {
            /// Layer 1
            VStack(spacing: 0) {
                ScrollView {
                    /// Layer 1 : ItemDetail Scroll View
                    VStack(spacing: 0) {
                        /// Layer 1 : Image Slider
                        PagingView(index: $index.animation(),
                                   maxIndex: viewModel.product!.itemImages.count-1) {
                            ForEach(viewModel.product!.itemImages, id: \.self) { imageUrl in
                                ImageView(withURL: imageUrl, isComingFromHomepage: false)
                            }
                        }.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/3)
                        /// Layer 1 : SellerProfile
                        NavigationLink(
                            destination: UserProfileView(viewModel: UserProfileViewModel(uId: viewModel.product!.sellerId)).navigationBarHidden(true)){
                            self.sellerProfile
                                .foregroundColor(.black)
                        }
                        /// Divider between Seller Profile / ItemDetail Contents
                        Divider().frame(width: UIScreen.screenWidth * 0.9)
                        /// Layer 1 : Product Detail
                        self.productContents
                    }
                }
                /// Layer 1 : Purchase Toolbar
                self.purchaseBottomBar
                    
            }.edgesIgnoringSafeArea(.top)
            /// Layer 2
            topStickyToolbar
        }
    }
    
    var sellerProfile: some View {
        /// Seller Profile View
        HStack {
            HStack(spacing: 0) {
                CircleImageView(imageString: viewModel.product!.sellerProfileIcon)
                    .frame(width:UIScreen.screenWidth / 7, height: UIScreen.screenWidth / 7)
                
                VStack(alignment: .leading, spacing: 3) {
                    Text(viewModel.product!.sellerName)
                        .font(Font.system(size: 22))
                        .bold()
                    Text(viewModel.product!.sellerSchool)
                        .font(Font.system(size: 18))
                        .foregroundColor(.gray)
                }.padding(.leading, 10)
            }
            Spacer()
            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text("국적")
                        .font(Font.system(size: 18))
                        .bold()
                    Image(viewModel.product!.sellerLocale)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                }
                HStack {
                    Text("평점")
                        .font(Font.system(size: 18))
                        .bold()
                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.yellow)
                        .frame(width: 18)
                    Text(String(viewModel.product!.sellerRating))
                        .font(Font.system(size: 18))
                        .bold()
                }
            }.frame(width: UIScreen.screenWidth / 3)
            .padding(.trailing, 15)
            
            
        }.padding(.vertical, 20)
        .padding(.leading, 10)
    }
    
    var productContents: some View {
        /// Contents Body View
        VStack(alignment: .leading, spacing: 8) {
            /// Item Title
            Text(self.viewModel.product!.itemTitle)
                .font(.title2)
                .bold()
                .padding(.horizontal, 10)
            /// Item Category
            Text(self.viewModel.product!.itemCategory)
                .font(.body)
                .foregroundColor(.gray)
                .padding(.leading, 10)
            
            /// Item Registration Time
            Text(calcDateDiff(baseDateTimestamp: self.viewModel.product!.itemTimeline))
                .font(.body)
                .foregroundColor(.gray)
                .padding(.leading, 10)
            
            /// Item Description
            Text(self.viewModel.product!.itemContents)
                .lineLimit(nil)
                .font(.body)
                .multilineTextAlignment(.leading)
                .padding(10)
            
            /// Item Relevant Data
            HStack(spacing: 5){
                Spacer()
                HStack(spacing: 3) {
                    if (viewModel.product!.cnt_chat > 0) {
                        Image("chat")
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text(String(viewModel.product!.cnt_chat))
                            .font(.body)
                    }
                }
                HStack(spacing: 3) {
                    if (viewModel.product!.cnt_like > 0) {
                        Image("heart")
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text(String(viewModel.product!.cnt_like))
                            .font(.body)
                    }
                }
                HStack(spacing: 3) {
                    Text(String(format: "%@ %d", "조회수", viewModel.product!.cnt_show))
                        .font(.body)
                }
            }.padding(.trailing, 20)
        }
        .frame(width: UIScreen.screenWidth, alignment: .leading)
        .padding(.vertical, 15)
    }
    
    var purchaseBottomBar: some View {
        VStack(spacing: 0) {
            Divider()
            HStack{
                Spacer()
                /// Like Button
                Image(systemName: "heart")
                    .font(.title)
                Spacer()
                /// Item Price
                Text(String(format: "%d %@", self.viewModel.product!.itemPrice, "원") )
                    .font(.title2)
                    .bold()
                Spacer()
                /// Purchase Button
                Text("구매 요청")
                    .bold()
                    .buttonStyleCottenCandy()
                    .frame(width: UIScreen.screenWidth / 4, height: 35)
                Spacer()
            }.padding(.top, 15)
        }.padding(.bottom, 10)
        .background(Color(.white))
    }
    
    var topStickyToolbar: some View {
        VStack {
            HStack{
                Button(action: { presentation.wrappedValue.dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(Font.system(size: UIScreen.screenWidth / 15))
                }.foregroundColor(.black)
                .padding(.leading, 15)
                Spacer()
                
            }
            Spacer()
        }
    }
    
}
