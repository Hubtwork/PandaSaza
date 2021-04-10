//
//  Statics.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/10.
//

import Foundation

// MARK:- Models

struct School: Hashable, Codable, Equatable {
    
    let sId: ID
    let name: String
    
    typealias ID = Int
}


// MARK:- Helpers

extension School: Identifiable {
    var id: ID { sId }
}
