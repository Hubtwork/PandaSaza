//
//  ImageUploaderTest.swift
//  Panda-SazaTests
//
//  Created by 허재 on 2021/05/18.
//

import UIKit
import XCTest
import Combine
@testable import Panda_Saza

class ImageUploaderTest: XCTestCase {
    
    let appState = CurrentValueSubject<AppState, Never>(AppState())
    private var apiRepository: ProfileApiRepository!
    private var cancelBag = CancelBag()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        let session = URLSession(configuration: configuration)
        
        appState.value = AppState()
        apiRepository = PandasazaProfileApiRepository(session: session, baseURL: "http://localhost:3030/service/profile")
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test1_uploadImage_Example() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let image: UIImage = UIImage(systemName: "return")!
        var response: ImageUploadResponseModel?
        let exp = XCTestExpectation(description: "Completion")
        apiRepository.basicImageUpload(image: image)
            .sinkToResult { result in
                if result.isSuccess {
                    try? response = result.get()
                    print(response)
                    exp.fulfill()
                }
            }
            .store(in: cancelBag)
        wait(for: [exp], timeout: 2)
    }
    
    func test2_changeProfile_Example() throws {
        let image: UIImage = UIImage(systemName: "return")!
        var response: ProfileModel?
        let exp = XCTestExpectation(description: "Completion")
        let accessToken = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwaG9uZSI6IjAxMDc1MTg3MjYwIiwiYWNjb3VudElkIjoiM2Q2ZWEyMDktNzhlYi00MjRhLTg0MjgtZTI4MjBhOGEzYmJhIiwiaWF0IjoxNjIxMzMyNDU3LCJleHAiOjE2MjE0MTg4NTcsImlzcyI6InBhbmRhU2F6YSJ9.nf9jVr8QkVAybMmIRKbLiTXtEs0_EV_5Ecl9HRcCUoo"
        apiRepository.changeProfileImage(accessToken: accessToken, profileName: "호우재", profileImage: image)
            .sinkToResult { result in
                if result.isSuccess {
                    try? response = result.get()
                    print(response)
                    exp.fulfill()
                }
            }
            .store(in: cancelBag)
        wait(for: [exp], timeout: 2)
    }

}
