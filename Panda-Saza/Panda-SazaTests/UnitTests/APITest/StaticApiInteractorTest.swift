//
//  StaticApiInteractorTest.swift
//  Panda-SazaTests
//
//  Created by Jae Heo on 2021/04/10.
//

import XCTest
import SwiftUI
import Combine
@testable import Panda_Saza

class StaticApiInteractorTest: XCTestCase {
    
    let appState = CurrentValueSubject<AppState, Never>(AppState())
    private var apiRepository: PandasazaStaticApiRepository!
    private var interactor: PandaSazaStaticApiInteractor!
    private var cancelBag = CancelBag()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        let session = URLSession(configuration: configuration)
        
        appState.value = AppState()
        apiRepository = PandasazaStaticApiRepository(session: session, baseURL: "http://localhost:3000/static")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_connectionTest() throws {
        let exp = XCTestExpectation(description: "Completion")
        apiRepository.getSchools()
            .sinkToResult {
                print($0)
                exp.fulfill()
            }.store(in: cancelBag)
        wait(for: [exp], timeout: 2)
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
