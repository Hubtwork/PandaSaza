//
//  ProfileChangeViewModel.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/09.
//

import SwiftUI

class ProfileChangeViewModel: ObservableObject {
    @Published var profileIcon: UIImage?
    @Published var profileName: String?
    
    init() {
        fetchProductCatalog()
    }
    
    func fetchProductCatalog() {
        if let url = Bundle.main.url(forResource: "user_data", withExtension: "json") {
            if let data = try? Data(contentsOf: url) {
                let jsondecoder = JSONDecoder()
                
                do {
                    let result = try jsondecoder.decode(UserDataLocal.self, from: data)
                    self.profileName = result.userData.userName
                    
                    let url = URL(string: result.userData.userProfileIcon)
                    let data = try Data(contentsOf: url!)
                    self.profileIcon = UIImage(data: data)
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
