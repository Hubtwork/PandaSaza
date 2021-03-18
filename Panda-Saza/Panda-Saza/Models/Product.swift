//
//  Product.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/18.
//

import Foundation

struct Product: Codable, Equatable {
    
    /// Item Reference Data
    let itemId: Int
    let itemName: String
    let itemNameTrans: String
    let itemPrice: Int
    let registrationTime: Double
    /// Seller Reference Data
    let sellerLoc: String
    /// Item Communication Data
    let itemInterest: Int
    let cnt_chat: Int
    let cnt_like: Int
    let thumbnailImageUrl: URL?
}

extension Product {
    struct ResponseReference: Codable, Equatable {
        let transaction_time: String
        let result_code: String
        let description: String
    }
}

extension Product {
    struct Details: Codable, Equatable {
        
        /// Item Reference Data
        let item_id: Int
        let status: String
        let name: String
        let title: String
        let content: String
        let price: Int
        let registered_at: Double
        let item_images_url: [URL]
        let type: String
        /// Item Communication Data
        let cnt_like: Int
        let cnt_chat: Int
        let cnt_show: Int
    }
}
// MARK: - Identifier Helpers

extension Product: Identifiable {
    var id: Int { itemId }
}


extension Product.Details: Identifiable {
    var id: Int { item_id }
}
