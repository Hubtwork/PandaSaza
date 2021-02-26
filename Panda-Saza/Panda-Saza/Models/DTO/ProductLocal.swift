//
//  ProductLocal.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/26.
//

import Foundation

struct ProductLocal: Codable {
    var products: [ProductThumbnail]
    
    enum CodingKeys: String, CodingKey {
        case products = "products"
    }
}
