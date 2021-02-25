//
//  ItemThumbnailView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/23.
//

import SwiftUI

struct ItemThumbnailView: View {
    
    var item = ItemThumbnail(id: 1, itemName: "가방", itemNameTrans: "Bag", itemPrice: 1000, registrationTime: 1614129326, sellerLoc: "동국대학교", interest: 3, thumbnailImageURL:
                                "https://s3.ap-northeast-2.amazonaws.com/product-partner//1603188907295-925c27f9-f843-4e76-af6e-ea338477f6ce.jpg")
    
    var body: some View {
        VStack(alignment: .leading){
            ImageView(url: URL(string: item.thumbnailImageURL)!,
                      placeholder: { Text("Loading") },
                      image: { Image(uiImage: $0).resizable() } )
                .background(Color(.white))
                .modifier(RoundedEdge(width: 1, color: .black, cornerRadius: 5))
            
            Text("(Trans) " + item.itemNameTrans)
                .bold()
                .scaledFont(size: 10)
                .padding(.top, -8)
            Text(item.itemName)
                .bold()
                .scaledFont(size: 10)
            
            Text(item.sellerLoc + " • " + calcDateDiff(baseDateTimestamp: item.registrationTime))
                .foregroundColor(.gray)
                .scaledFont(size: 8)
            
            Text(String(format: "%d %@", item.itemPrice, "원"))
                .bold()
                .scaledFont(size: 9)
        }
    }
}

struct ItemThumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemThumbnailView()
    }
}
