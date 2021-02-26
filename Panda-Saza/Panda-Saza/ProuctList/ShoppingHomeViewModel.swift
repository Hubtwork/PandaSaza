//
//  ShoppingHomeViewModel.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/26.
//

import Foundation

class ShoppingHomeViewModel: ObservableObject {
    @Published var products = [ProductThumbnail]()
    
    init() {
        fetchProductCatalog()
    }
    
    func fetchProductCatalog() {
        if let url = Bundle.main.url(forResource: "products", withExtension: "json") {
            if let data = try? Data(contentsOf: url) {
                let jsondecoder = JSONDecoder()
                
                do {
                    let result = try jsondecoder.decode(ProductLocal.self, from: data)
                    self.products = result.products
                }
                catch {
                    print(error)
                }
            }
        } else {
        print("Error loading JSON URL")
        }
    }
    
    func getSubTotal(products: [ProductThumbnail]) -> Int {
        var total = 0
        for product in products {
            total = total + product.itemPrice
        }
        return total
    }
}
