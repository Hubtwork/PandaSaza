//
//  ChattingListViewModel.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/04.
//

import Foundation

class ChattingListViewModel: ObservableObject {
    @Published var chattingList = [ChattingThumbnail]()
    
    init() {
        fetchProductCatalog()
    }
    
    func fetchProductCatalog() {
        if let url = Bundle.main.url(forResource: "chatting", withExtension: "json") {
            if let data = try? Data(contentsOf: url) {
                let jsondecoder = JSONDecoder()
                
                do {
                    let result = try jsondecoder.decode(ChattingLocal.self, from: data)
                    self.chattingList = result.chattingList
                }
                catch {
                    print(error)
                }
            }
        } else {
        print("Error loading JSON URL")
        }
    }
}
