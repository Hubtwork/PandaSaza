//
//  SignApiRepositoryTest.swift
//  Panda-SazaTests
//
//  Created by 허재 on 2021/05/11.
//

import XCTest
import Combine
@testable import Panda_Saza

class SignApiRepositoryTest: XCTestCase {

    let appState = CurrentValueSubject<AppState, Never>(AppState())
    private var apiRepository: PandasazaSignApiRepository!
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
        apiRepository = PandasazaSignApiRepository(session: session, baseURL: "http://localhost:3030/sign")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test1_sign_register_success() throws {
        var apiResponse: LoginModel?
    
        let image: UIImage = UIImage(systemName: "return")!
    
        let registerInfo: RegistrationModel = RegistrationModel(phone: "01075187260",
                                                            school: "Dongguk Univ.", nationality: "Republic Of Korea",
                                                            profileName: "마스터")
        let exp = XCTestExpectation(description: "Completion")
        apiRepository.register(registration: registerInfo, profileImage: image)
            .sinkToResult { result in
                XCTAssertTrue(Thread.isMainThread)
                if result.isSuccess {
                    try? apiResponse = result.get().data
                    XCTAssertTrue(apiResponse != nil)
                    XCTAssertTrue(apiResponse!.accountId.count > 0)
                    XCTAssertTrue(apiResponse!.phone == "01075187260")
                    XCTAssertTrue(apiResponse!.tokens.accessToken.count > 0)
                    XCTAssertTrue(apiResponse!.tokens.refreshToken.count > 0)
                    print(String(describing: apiResponse))
                    
                    exp.fulfill()
                }
            }
            .store(in: cancelBag)
        wait(for: [exp], timeout: 2)
    }
    
    func test2_sign_logout_success() throws {
        var apiResponse: MsgResponse?
        let phone = "01075187260"
        let exp = XCTestExpectation(description: "Completion")
        apiRepository.logout(phone: phone)
            .sinkToResult { result in
                XCTAssertTrue(Thread.isMainThread)
                if result.isSuccess {
                    try? apiResponse = result.get()
                    if apiResponse?.apiStatusCode == "PS00" {
                        print("Whole Response From Server: \(String(describing: apiResponse))")
                        exp.fulfill()
                    }
                }
            }
            .store(in: cancelBag)
        wait(for: [exp], timeout: 2)
    }
    
    func test3_sign_register_fail_alreadayRegisteredWithThePhone() throws {
        
        let image: UIImage = UIImage(systemName: "return")!
        let registerInfo: RegistrationModel = RegistrationModel(phone: "01075187260",
                                                            school: "Dongguk Univ.", nationality: "Republic Of Korea",
                                                            profileName: "마스터")
        let exp = XCTestExpectation(description: "Completion")
        apiRepository.register(registration: registerInfo, profileImage: image)
            .sinkToResult { result in
                XCTAssertTrue(Thread.isMainThread)
                if !result.isSuccess {
                    print("에러 : \(result)")
                    exp.fulfill()
                }
            }
            .store(in: cancelBag)
        wait(for: [exp], timeout: 2)
    }
    
    func test4_sign_logout_fail_noUserLoggedInWithThePhone() throws {
        let phone = "01075187260"
        let exp = XCTestExpectation(description: "Completion")
        apiRepository.logout(phone: phone)
            .sinkToResult { result in
                XCTAssertTrue(Thread.isMainThread)
                if !result.isSuccess {
                    print("에러 : \(result)")
                    exp.fulfill()
                }
            }
            .store(in: cancelBag)
        wait(for: [exp], timeout: 2)
    }
    
    func test5_sign_login_success() throws {
        var apiResponse: DataResponse<LoginModel>?
        let phone = "01075187260"
        let exp = XCTestExpectation(description: "Completion")
        apiRepository.login(phone: phone)
            .sinkToResult { result in
                XCTAssertTrue(Thread.isMainThread)
                if result.isSuccess {
                    try? apiResponse = result.get()
                    XCTAssertTrue(apiResponse != nil)
                    XCTAssertTrue(apiResponse?.apiStatusCode == "PS00")
                    if apiResponse?.apiStatusCode == "PS00" {
                        let accountData = apiResponse!.data
                        print("Tokens: \(accountData.tokens)")
                        exp.fulfill()
                    }
                }
            }
            .store(in: cancelBag)
        wait(for: [exp], timeout: 2)
    }
    
    func test6_sign_login_fail_userWithThePhoneAlreadyLoggedIn() throws {
        let phone = "01075187260"
        let exp = XCTestExpectation(description: "Completion")
        apiRepository.login(phone: phone)
            .sinkToResult { result in
                XCTAssertTrue(Thread.isMainThread)
                if !result.isSuccess {
                    print("에러 : \(result)")
                    exp.fulfill()
                }
            }
            .store(in: cancelBag)
        wait(for: [exp], timeout: 2)
    }
    

}
