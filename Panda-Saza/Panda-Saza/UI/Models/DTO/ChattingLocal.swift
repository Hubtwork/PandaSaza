//
//  ChattingLocal.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/04.
//

import Foundation

struct ChattingLocal: Codable {
    var chattingList: [ChattingThumbnail]
    
    enum CodingKeys: String, CodingKey {
        case chattingList = "chattingThumbnails"
    }
}
