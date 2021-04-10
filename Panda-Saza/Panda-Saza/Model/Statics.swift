//
//  Statics.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/10.
//

import Foundation

// MARK:- Models

struct Schools: Hashable, Codable, Equatable {
    
    let area: String
    let schools: [School]
    
}

struct School: Hashable, Codable, Equatable {
    
    let sId: ID
    let name: String
    
    typealias ID = Int
}


// MARK:- Helpers

extension School: Identifiable {
    var id: ID { sId }
}
