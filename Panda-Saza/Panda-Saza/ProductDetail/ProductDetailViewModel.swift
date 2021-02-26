//
//  ProductDetailViewModel.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/26.
//

import Foundation

class ProductDetailViewModel: ObservableObject {
    @Published var product: ProductDetail?
    
    init(pId: Int) {
        fetchProductCatalog(productId: pId)
    }
    
    func fetchProductCatalog(productId: Int) {
        if let url = Bundle.main.url(forResource: "product_detail"+String(productId), withExtension: "json") {
            if let data = try? Data(contentsOf: url) {
                let jsondecoder = JSONDecoder()
                
                do {
                    let result = try jsondecoder.decode(ProductDetailLocal.self, from: data)
                    self.product = result.product
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
