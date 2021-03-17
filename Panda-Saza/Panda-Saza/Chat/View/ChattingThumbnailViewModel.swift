//
//  ChattingViewViewModel.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/04.
//

import Foundation

class ChattingThumbnailViewModel: ObservableObject {
    var chat: ChattingThumbnail
    
    init(chat: ChattingThumbnail) {
        self.chat = chat
    }
}
