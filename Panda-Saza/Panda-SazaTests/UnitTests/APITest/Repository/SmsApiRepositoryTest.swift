//
//  SignApiRepositoryTest.swift
//  Panda-SazaTests
//
//  Created by 허재 on 2021/05/11.
//

import XCTest
import SwiftUI
import Combine
@testable import Panda_Saza

class SmsApiRepositoryTest: XCTestCase {
    
    let appState = CurrentValueSubject<AppState, Never>(AppState())
    private var apiRepository: PandasazaSmsApiRepository!
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
        apiRepository = PandasazaSmsApiRepository(session: session, baseURL: "http://localhost:3030/sms")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_smsValidation_success() throws {
        var apiResponse: DataResponse<JsonSMSValidation>?
        let exp = XCTestExpectation(description: "Completion")
        apiRepository.smsValidation(phone: "01075187260")
            .sinkToResult { result in
                XCTAssertTrue(Thread.isMainThread)
                if result.isSuccess {
                    try? apiResponse = result.get()
                    if apiResponse?.apiStatusCode == "PS00" {
                        let smsValidation = apiResponse!.data
                        print("Whole Response From Server: \(String(describing: apiResponse))")
                        print("SMS Validation CODE: \(smsValidation.validationCode)")
                        exp.fulfill()
                    }
                }
            }
            .store(in: cancelBag)
        wait(for: [exp], timeout: 2)
    }
    
    func test_smsVerification_success() throws {
        var apiResponse: DataResponse<JsonSMSVerification>?
        let exp = XCTestExpectation(description: "Completion")
        apiRepository.smsVerification(phone: "01075187260")
            .sinkToResult { result in
                XCTAssertTrue(Thread.isMainThread)
                if result.isSuccess {
                    try? apiResponse = result.get()
                    if apiResponse?.apiStatusCode == "PS00" {
                        let smsVerification = apiResponse!.data
                        print("Whole Response From Server: \(String(describing: apiResponse))")
                        print(" Phone [ \(smsVerification.phone)] : Registered [ \(smsVerification.registered)")
                        exp.fulfill()
                    }
                }
            }
            .store(in: cancelBag)
        wait(for: [exp], timeout: 2)
    }
    
}
