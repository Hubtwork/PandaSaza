//
//  ProfileApiRepository.swift
//  Panda-Saza
//
//  Created by 허재 on 2021/05/15.
//

import Foundation
import Combine
import SwiftUI

protocol ProfileApiRepository: ApiRepository {
    func profileImageUpload(image: Image)
}


struct PandasazaProfileApiRepository: ProfileApiRepository {
    
    let session: URLSession
    let baseURL: String
    
    let backgroundQueue = DispatchQueue(label: "bg_parse_queue")
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func profileImageUpload(image: Image) {
        
    }
    
}


extension PandasazaProfileApiRepository {
    enum API {
        case profileImageUpload
    }
}

extension PandasazaProfileApiRepository.API: ApiRequest {
    
    var path: String {
        switch self {
        case .profileImageUpload:
            return "/imageUpload/profileImage"
        }
    }
    
    var method: String {
        switch self {
        case .profileImageUpload:
            return "PUT"
        }
    }
    
    var headers: [String: String]? {
        return ["Accept": "application/json"]
    }
    
    func body(params: [String: Any] = [:]) throws -> Data? {
        return nil
    }
}
