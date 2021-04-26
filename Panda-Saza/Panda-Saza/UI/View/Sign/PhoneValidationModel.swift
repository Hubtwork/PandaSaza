//
//  SIgnUpValidationModel.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/09.
//

import Foundation
import Combine


class PhoneValidationModel: ObservableObject {
    
    // MARK: - Form Input
    
    // values
    /// Phase 1 - depend on userAuthType
    @Published var phone: String = "" {
        didSet {
            if phone.count > 11 && oldValue.count <= 11 { phone = oldValue }
        }
    }
    @Published var phoneAuthCode: String = "" {
        didSet {
            if phoneAuthCode.count > 4 && oldValue.count <= 4 { phoneAuthCode = oldValue }
        }
    }
    
    @Published var token: String = ""
    
    // MARK: - Validation Output
    /// Phase 1
    @Published var validPhone: Bool = false
    
    private let cancelBag = CancelBag()
    
    func clearAll() {
        self.phone = ""
        self.phoneAuthCode = ""
        self.validPhone = false
    }
    
    
    init() {
        isPhoneValidPublisher
            .receive(on: RunLoop.main)
            .map { check in
                switch check {
                case .empty, .violateRules: return false
                case .valid: return true
                }
            }
            .assign(to: \.validPhone, on: self)
            .store(in: cancelBag)
    }
    
    // MARK: - Phone Checker
    
    enum PhoneStatus {
        case valid
        case empty
        case violateRules
    }
    
    private var isPhoneEmptyPublisher: AnyPublisher<Bool, Never> {
        $phone
          .removeDuplicates()
          .map { phone in
            return phone.isEmpty
          }
          .eraseToAnyPublisher()
    }
    
    private var isPhoneViolateRulesPublisher: AnyPublisher<Bool, Never> {
        $phone
          .removeDuplicates()
          .map { phone in
            return phone.count <= 8
          }
          .eraseToAnyPublisher()
      }
    
    private var isPhoneValidPublisher: AnyPublisher<PhoneStatus, Never> {
        Publishers.CombineLatest(isPhoneEmptyPublisher, isPhoneViolateRulesPublisher)
            .map { isPhoneEmpty, isPhoneViolateRules in
                if (isPhoneEmpty) {
                    return .empty
                }
                else if (isPhoneViolateRules) {
                    return .violateRules
                }
                else {
                    return .valid
                }
            }.eraseToAnyPublisher()
    }
}
