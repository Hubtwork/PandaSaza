//
//  ProductImageContainer.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/29.
//

import SwiftUI

struct ProductImageContainer: View {
    
    @State private var imageIndex: Int = 0
    
    // UI reference
    let width: CGFloat = UIScreen.screenWidth
    let height: CGFloat = UIScreen.screenHeight/3
    
    let images: [URLImageView]
    
    init(imageUrlStrings: [String]) {
        var images = [URLImageView]()
        
        for imageUrl in imageUrlStrings {
            images.append(URLImageView(urlString: imageUrl))
        }
        self.images = images
    }
    
    var body: some View {
        PagingView(index: $imageIndex.animation(),
                   maxIndex: images.count-1) {
            ForEach(images, id: \.self) { imageView in
                imageView
            }
        }.frame(width: width, height: height)
    }
}

struct ProductImageContainer_Previews: PreviewProvider {
    static var previews: some View {
        ProductImageContainer(imageUrlStrings: [
            "https://media.gucci.com/style/DarkGray_Center_0_0_1200x1200/1586349905/625599_H9HAN_7560_001_080_0000_Light-.jpg",
            "https://media.gucci.com/style/Transparent_Center_0_0_500x340/1600098306/476433_0OLFT_2535_001_050_0000_Light.png",
            "https://media.gucci.com/style/Transparent_Center_0_0_500x340/1613085303/476433_UAMBM_9251_001_057_0010_Light.png"
        ])
    }
}
