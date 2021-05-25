//
//  Core.swift
//  PandaSaza-ios
//
//  Created by 허재 on 2021/05/25.
//

import Foundation

struct DataResponse<T : Codable>: Codable {
    let apiStatusCode: String
    let message: String
    let data: T?
}
