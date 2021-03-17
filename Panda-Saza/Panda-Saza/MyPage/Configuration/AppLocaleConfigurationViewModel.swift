//
//  PushSoundConfigurationViewModel.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/17.
//

import Foundation

class AppLocaleConfigurationViewModel: ObservableObject {
    @Published var languages: AppLanguage?
    
    init() {
        fetchProductCatalog()
    }
    
    func fetchProductCatalog() {
        if let url = Bundle.main.url(forResource: "language", withExtension: "json") {
            if let data = try? Data(contentsOf: url) {
                let jsondecoder = JSONDecoder()
                
                do {
                    let result = try jsondecoder.decode(AppLanguage.self, from: data)
                    self.languages = result
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
