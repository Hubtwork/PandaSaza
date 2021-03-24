//
//  ImageView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/23.
//

import Foundation
import Combine
import SwiftUI

// Helper class that allows to load custom image views
struct ImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()
    var isOnHomepage: Bool
    
    init(withURL url:String, isComingFromHomepage: Bool) {
        imageLoader = ImageLoader(urlString:url)
        self.isOnHomepage = isComingFromHomepage
    }
    
    @ViewBuilder
    var body: some View {
        if isOnHomepage {
            shopHomeViewImageView
        } else {
            detailViewImageView
        }
    }
}

private extension ImageView {
    var shopHomeViewImageView: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 120, alignment: .top)
            
        }.onReceive(imageLoader.dataPublisher) { data in
            self.image = UIImage(data: data) ?? UIImage()
        }
    }
    
    var detailViewImageView: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 300)
            
        }.onReceive(imageLoader.dataPublisher) { data in
            self.image = UIImage(data: data) ?? UIImage()
        }
    }
}

let imgs = [
    "https://s3.ap-northeast-2.amazonaws.com/productmain/20210206_637481784803922153_1892825_0.jpg",
    "https://s3.ap-northeast-2.amazonaws.com/productmain/20210212_637487050926479021_2497982_0.jpg",
    "https://s3.ap-northeast-2.amazonaws.com/productmain/20210203_637479781414629829_31029_0.jpg",
    "https://s3.ap-northeast-2.amazonaws.com/product-partner//1603188907295-925c27f9-f843-4e76-af6e-ea338477f6ce.jpg"
]


struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        List(imgs, id: \.self) { url in
            ImageView(withURL: url, isComingFromHomepage: false)
                .frame(width: UIScreen.screenWidth * 0.9, height: UIScreen.screenHeight / 3)
                .background(Color(.white))
                .border(Color.black)
        }
    }
}
