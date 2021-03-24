//
//  CategoryViewModel.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/01.
//

import Foundation

class CategoryViewModel: ObservableObject {
    @Published var category: Category?
    
    init() {
        fetchProductCatalog()
    }
    
    func fetchProductCatalog() {
        if let url = Bundle.main.url(forResource: "itemCategory", withExtension: "json") {
            if let data = try? Data(contentsOf: url) {
                let jsondecoder = JSONDecoder()
                
                do {
                    let result = try jsondecoder.decode(Category.self, from: data)
                    self.category = result
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
