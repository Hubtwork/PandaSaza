//
//  PushSound.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/14.
//

import Foundation

struct PushSound: Codable, Identifiable {
    var id = UUID()
    let sound: [String]

    enum CodingKeys: String, CodingKey {
        case sound
    }
}
