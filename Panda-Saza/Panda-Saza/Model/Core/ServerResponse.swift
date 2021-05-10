//
//  ServerResponse.swift
//  Panda-Saza
//
//  Created by 허재 on 2021/05/10.
//

import Foundation


struct MsgResponse: Codable {
    let apiStatusCode: String
    let message: String
}

struct DataResponse<T : Codable>: Codable {
    let apiStatusCode: String
    let message: String
    let data: T
}
