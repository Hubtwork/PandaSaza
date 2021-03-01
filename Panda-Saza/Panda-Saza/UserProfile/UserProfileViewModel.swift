//
//  UserProfileViewModel.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/01.
//

import Foundation

class UserProfileViewModel: ObservableObject {
    @Published var user: UserProfile?
    
    init(uId: Int) {
        fetchProductCatalog(userId: uId)
    }
    
    func fetchProductCatalog(userId: Int) {
        if let url = Bundle.main.url(forResource: "user_profile"+String(userId), withExtension: "json") {
            if let data = try? Data(contentsOf: url) {
                let jsondecoder = JSONDecoder()
                
                do {
                    let result = try jsondecoder.decode(UserProfileLocal.self, from: data)
                    self.user = result.userProfile
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
