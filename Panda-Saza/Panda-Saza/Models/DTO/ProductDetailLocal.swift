//
//  ProductDetailLocal.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/26.
//

import Foundation

struct ProductDetailLocal: Codable {
    var product: ProductDetail
    
    enum CodingKeys: String, CodingKey {
        case product = "productdetail"
    }
}
