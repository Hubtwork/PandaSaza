//
//  Products.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/25.
//

import Foundation

struct Product: Codable, Equatable {
    
    let itemId: ID
    let thumbnailImageURL: URL?
    let itemCategory: String
    let itemName: String
    let itemNameTrans: String
    let itemPrice: Int
    
    let registrationTime: Double
    
    let sellerLoc: String
    
    let cnt_chat: Int
    let cnt_like: Int
    
    typealias ID = Int
}

struct ProductDetails: Codable, Equatable {
    
    let itemId: ID
    let itemImages: [URL]
    let itemCategory: String
    let itemTitle: String
    let itemContents: String
    let itemPrice: Int
    
    let registrationTime: Double
    
    let cnt_chat: Int
    let cnt_like: Int
    let cnt_show: Int
    /// Seller Reference
    let sellerId: ID
    let sellerName: String
    let sellerProfileIcon: URL?
    let sellerSchool: String
    let sellerLocale: String
    let sellerRating: Double
    
    
    typealias ID = Int
}

// MARK:- Helpers
extension Product: Identifiable {
    var id: ID { itemId }
}

extension ProductDetails: Identifiable {
    var id: ID { itemId }
}

// MARK: - MockedData
extension Product {
    static let mockedData: [Product] = [
        Product(itemId: 1, thumbnailImageURL: URL(string: "https://media.gucci.com/style/DarkGray_Center_0_0_1200x1200/1587569403/476433_DTDCT_1000_001_057_0000_Light-GG.jpg"), itemCategory: "악세서리", itemName: "구찌 가방", itemNameTrans: "Gucci Bag", itemPrice: 10000, registrationTime: 1614129326, sellerLoc: "동국대학교", cnt_chat: 1, cnt_like: 3),
        Product(itemId: 2, thumbnailImageURL: URL(string: "https://cdn.allets.com/commerce/goods/resize/900/20210122/1611304143038_%EC%8D%B8%EB%84%A4%EC%9D%BC.jpg"), itemCategory: "여성의류", itemName: "한복", itemNameTrans: "Korean Clothes", itemPrice: 34000, registrationTime: 1614124326, sellerLoc: "서강대학교", cnt_chat: 0, cnt_like: 4)
    ]
}
