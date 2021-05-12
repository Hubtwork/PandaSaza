//
//  SignInteractorTest.swift
//  Panda-SazaTests
//
//  Created by 허재 on 2021/05/12.
//

import XCTest
import Combine
@testable import Panda_Saza

class SignInteractorTest: XCTestCase {

    let appState = CurrentValueSubject<AppState, Never>(AppState())
    private var signRepository: PandasazaSignApiRepository!
    private var smsRepository: PandasazaSmsApiRepository!
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
        signRepository = PandasazaSignApiRepository(session: session, baseURL: "http://localhost:3030/sign")
        smsRepository = PandasazaSmsApiRepository(session: session, baseURL: "http://localhost:3030/sms")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_verifyingSMS_success() throws {
        
        var registered: Bool?
        let exp = XCTestExpectation(description: "Completion")
        
        smsRepository.verifyingSMS(phone: "01075187260")
            .sinkToResult{
                result in
                if result.isSuccess {
                    try? registered = result.get()
                    print("Registered? \(registered!)")
                    exp.fulfill()
                }
            }
            .store(in: cancelBag)
        wait(for: [exp], timeout: 2)
    }
    
    func test_requestSMSValidation_success() throws {
        
        var validationCode: String?
        let exp = XCTestExpectation(description: "Completion")
        
        smsRepository.requestSMSValidation(phone: "01075187260")
            .sinkToResult {
                result in
                if result.isSuccess {
                    try? validationCode = result.get()
                    print("ValidationCode: \(validationCode)")
                    exp.fulfill()
                }
            }
            .store(in: cancelBag)
        wait(for: [exp], timeout: 2)
        
    }

}
