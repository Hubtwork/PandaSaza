//
//  ChattingThumbnail.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/04.
//

import Foundation

struct ChattingThumbnail: Hashable, Codable {
    var id = UUID()
    
    let roomId: Int
    
    let partnerName: String
    let partnerProfileIcon: String
    let partnerLastDateTime: Double
    let partnerLastMessage: String
    
    enum CodingKeys: String, CodingKey {
        case roomId
        
        case partnerName
        case partnerProfileIcon
        case partnerLastDateTime
        case partnerLastMessage
    }
}
