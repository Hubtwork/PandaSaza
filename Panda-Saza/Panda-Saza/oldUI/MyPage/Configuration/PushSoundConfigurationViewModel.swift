//
//  PushSoundConfigurationViewModel.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/14.
//

import Foundation

class PushSoundConfigurationViewModel: ObservableObject {
    @Published var sounds: PushSound?
    
    init() {
        fetchProductCatalog()
    }
    
    func fetchProductCatalog() {
        if let url = Bundle.main.url(forResource: "sound", withExtension: "json") {
            if let data = try? Data(contentsOf: url) {
                let jsondecoder = JSONDecoder()
                
                do {
                    let result = try jsondecoder.decode(PushSound.self, from: data)
                    self.sounds = result
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
