//
//  SIgnUpValidationModel.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/09.
//

import Foundation
import Combine


class SignUpValidationModel: ObservableObject {
    
    // MARK: - Form Input
    
    @Published var type: UserAuthType = .email
    
    // values
    /// Phase 1 - depend on userAuthType
    @Published var email: String = ""
    
    @Published var phone: String = "" {
        didSet {
            if phone.count > 11 && oldValue.count <= 11 { phone = oldValue }
        }
    }
    @Published var phoneAuthCode: String = ""
    
    @Published var token: String = ""
    
    // Common
    /// Phase 2
    @Published var school: String = ""
    /// Phase 3
    @Published var language: String = ""
    /// Phase 4
    @Published var profileName: String = ""
    @Published var profileImage: URL?

    
    
    // MARK: - Validation Output
    /// Phase 1
    @Published var validPhone: Bool = false
    @Published var alertPhone: String = ""
    
    
    // MARK: - Authenticated Data
    /// Phase 1
    @Published var authPhone: String = ""
    
    private let cancelBag = CancelBag()
    
    
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
            let numberCharacters = CharacterSet.decimalDigits.inverted
            return phone.rangeOfCharacter(from: numberCharacters) == nil && phone.count <= 8
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
