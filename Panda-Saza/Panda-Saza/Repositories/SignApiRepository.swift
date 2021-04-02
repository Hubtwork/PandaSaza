//
//  SignApiRepository.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/02.
//

import Combine
import Foundation

protocol SignApiRepository: ApiRepository {
    
    func loadProducts() -> AnyPublisher<[UserData], Error>
    
}
