//
//  DeepLinksHandler.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/26.
//

import Foundation

// MARK: - DeepLink
/**
    Entity about View Routing Point for Push Nofification
        Not Implemented Yet
 */

enum DeepLink: Equatable {
    
    case showProductDetails(productId: ProductDetails.ID)
    
    init?(url: URL) {
        return nil
    }
}

// MARK: - DeepLinksHandler

protocol DeepLinksHandler {
    func open(deepLink: DeepLink)
}
