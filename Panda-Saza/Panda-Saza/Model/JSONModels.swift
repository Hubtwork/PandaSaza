//
//  JSONModels.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/13.
//

import Foundation

// MARK:- Models

struct JsonSmsValidation: Hashable, Codable, Equatable {
    
    let success: Bool
    let code: Int
    let response: Int
    
}

