//
//  Category.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/01.
//

import Foundation

struct Category: Codable, Identifiable {
    var id = UUID()
    let category: [String]

    enum CodingKeys: String, CodingKey {
        case category
    }
}
