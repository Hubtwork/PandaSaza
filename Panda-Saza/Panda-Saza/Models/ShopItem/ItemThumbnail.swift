//
//  ItemThumbnail.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/23.
//

import Foundation
import SwiftUI

struct ItemThumbnail: Hashable, Codable {
    var id: Int
    var itemName: String
    var itemNameTrans: String
    var itemPrice: Int
    
    var registrationTime: Double
    
    var sellerLoc: String
    var interest: Int
    
    var thumbnailImageURL: String
}
