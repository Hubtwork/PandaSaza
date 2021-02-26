//
//  ProductThumbnailViewModel.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/26.
//

import Foundation

class ProductThumbnailViewModel: ObservableObject {
    var product: ProductThumbnail
    
    init(product: ProductThumbnail) {
        self.product = product
    }
}
