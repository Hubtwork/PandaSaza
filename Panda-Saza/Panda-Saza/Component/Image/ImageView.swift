//
//  ImageView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/23.
//

import SwiftUI

struct ImageView<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Placeholder
    private let image: (UIImage) -> Image
    
    init(
        url: URL,
        @ViewBuilder placeholder: () -> Placeholder,
        @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)
    ) {
        self.placeholder = placeholder()
        self.image = image
        _loader = StateObject(wrappedValue: ImageLoader(url: url, cache: Environment(\.imageCache).wrappedValue))
    }
    
    var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    
    private var content: some View {
        Group {
            if loader.image != nil {
                image(loader.image!)
                    .scaledToFit()
            } else {
                placeholder
            }
        }
    }
}

let imgs = [
    "https://s3.ap-northeast-2.amazonaws.com/productmain/20210206_637481784803922153_1892825_0.jpg",
    "https://s3.ap-northeast-2.amazonaws.com/productmain/20210212_637487050926479021_2497982_0.jpg",
    "https://s3.ap-northeast-2.amazonaws.com/productmain/20210203_637479781414629829_31029_0.jpg",
    "https://s3.ap-northeast-2.amazonaws.com/product-partner//1603188907295-925c27f9-f843-4e76-af6e-ea338477f6ce.jpg"
].map { URL(string: $0)! }


struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        List(imgs, id: \.self) { url in
             ImageView(
                url: url,
                placeholder: { Text("Loading ...") },
                image: {
                    Image(uiImage: $0)
                        .resizable()
                }
             )
             .frame(width: 100, height: 100)
             .background(Color(.white))
             .modifier(RoundedEdge(width: 2, color: .black, cornerRadius: 10))
         }
    }
}
