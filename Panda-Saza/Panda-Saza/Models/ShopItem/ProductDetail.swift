//
//  ItemDetail.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/26.
//

import Foundation

struct ProductDetail: Codable, Identifiable {
    var id = UUID()
    let itemId: Int
    let itemTitle: String
    let itemImages: [String]
    let itemContents: String
    let itemCategory: String
    let itemTimeline: Double
    let itemPrice: Int
    
    let sellerId: Int
    let sellerName: String
    let sellerSchool: String
    let sellerLocale: String
    let sellerRating: Double

    enum CodingKeys: String, CodingKey {
        case itemId
        case itemTitle
        case itemImages
        case itemContents
        case itemCategory
        case itemTimeline
        case itemPrice
        
        case sellerId
        case sellerName
        case sellerSchool
        case sellerLocale
        case sellerRating
    }
}