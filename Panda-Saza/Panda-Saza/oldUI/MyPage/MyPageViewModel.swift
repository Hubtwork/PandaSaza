//
//  MyPageViewModel.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/03.
//

import Foundation

class MyPageViewModel: ObservableObject {
    @Published var user: UserData?
    
    init() {
        fetchProductCatalog()
    }
    
    func fetchProductCatalog() {
        if let url = Bundle.main.url(forResource: "user_data", withExtension: "json") {
            if let data = try? Data(contentsOf: url) {
                let jsondecoder = JSONDecoder()
                
                do {
                    let result = try jsondecoder.decode(UserDataLocal.self, from: data)
                    self.user = result.userData
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
