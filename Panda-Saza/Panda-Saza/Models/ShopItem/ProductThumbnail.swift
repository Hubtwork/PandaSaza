//
//  ItemThumbnail.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/23.
//

import Foundation

struct ProductThumbnail: Hashable, Codable {
    var id = UUID()
    let itemId: Int
    let itemName: String
    let itemNameTrans: String
    let itemPrice: Int
    
    let registrationTime: Double
    
    let sellerLoc: String
    let itemInterest: Int
    
    let thumbnailImageURL: String
    
    let cnt_chat: Int
    let cnt_like: Int
    
    enum CodingKeys: String, CodingKey {
        case itemId
        case itemName
        case itemNameTrans
        case itemPrice
        
        case registrationTime
        
        case sellerLoc
        case itemInterest
        
        case thumbnailImageURL
        case cnt_chat
        case cnt_like
    }
}
