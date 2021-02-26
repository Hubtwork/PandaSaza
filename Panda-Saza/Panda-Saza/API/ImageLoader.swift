//
//  ImageLoader.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/26.
//

import Foundation
import Combine

// Class that allows to load images from server asynchronously
class ImageLoader: ObservableObject {
    var dataPublisher = PassthroughSubject<Data, Never>()
        var data = Data() {
            didSet {
                dataPublisher.send(data)
            }
         }
    
    init(urlString:String) {
            guard let url = URL(string: urlString) else { return }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
               self.data = data
            }
        }
        task.resume()
      }
}
