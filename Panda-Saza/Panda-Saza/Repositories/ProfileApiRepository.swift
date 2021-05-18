//
//  ProfileApiRepository.swift
//  Panda-Saza
//
//  Created by 허재 on 2021/05/15.
//

import Foundation
import Combine
import SwiftUI
import UIKit

protocol ProfileApiRepository: ApiRepository {
    func basicImageUpload(image: UIImage) -> AnyPublisher<ImageUploadResponseModel, Error>
    
    func changeProfileImage(accessToken: String, profileName: String, profileImage: UIImage) -> AnyPublisher<ProfileModel, Error>
}


struct PandasazaProfileApiRepository: ProfileApiRepository {
    
    let session: URLSession
    let baseURL: String
    
    let backgroundQueue = DispatchQueue(label: "bg_parse_queue")
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func basicImageUpload(image: UIImage) -> AnyPublisher<ImageUploadResponseModel, Error> {
        let params = [
            "refreshToken": "tokenString",
            "user":"hubtwork"
        ]
        let imageUploadRequest: AnyPublisher<DataResponse<ImageUploadResponseModel>, Error> = imageRequest(endpoint: API.profileImageUpload, imageKey: "profile", image: image.pngData()!, params: params)
        return imageUploadRequest.map { return $0.data }.eraseToAnyPublisher()
    }
    
    func changeProfileImage(accessToken: String, profileName: String, profileImage: UIImage) -> AnyPublisher<ProfileModel, Error> {
        let params = [
            "profileName": profileName
        ]
        let changeProfileRequest: AnyPublisher<DataResponse<ProfileModel>, Error> = imageRequest(endpoint: API.changeProfileImage(accessToken), imageKey: "profileImage", image: profileImage.pngData()!, params: params)
        return changeProfileRequest.map{ return $0.data }.eraseToAnyPublisher()
    }
    
}


extension PandasazaProfileApiRepository {
    enum API {
        case profileImageUpload
        case changeProfileImage(String)
    }
}

extension PandasazaProfileApiRepository.API: ApiRequest {
    
    var path: String {
        switch self {
        case .profileImageUpload:
            return "/imageUploadTest"
        case .changeProfileImage:
            return "/my/change"
        }
    }
    
    var method: String {
        switch self {
        case .profileImageUpload, .changeProfileImage:
            return "PUT"
        }
    }
    
    var headers: [String: String]? {
        var headers = [
            "Accept": "application/json"
        ]
        switch self {
        case .profileImageUpload:
            headers["Authorization"] = "test"
            break
        case let .changeProfileImage(accessToken):
            headers["Authorization"] = accessToken
            break
        }
        return headers
    }
    
    func body(params: [String: Any] = [:]) throws -> Data? {
        return nil
    }
}
