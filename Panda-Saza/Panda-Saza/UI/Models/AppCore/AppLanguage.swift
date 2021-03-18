//
//  AppLanguage.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/17.
//

import Foundation

struct AppLanguage: Codable, Identifiable {
    var id = UUID()
    let language: [String]

    enum CodingKeys: String, CodingKey {
        case language
    }
}
