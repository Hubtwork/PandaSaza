//
//  Validation.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/01.
//

import Foundation
import Combine

class SignUpValidation: ObservableObject {
    
    // MARK: - Form Input
    
    // values
    @Published var email: String = ""
    @Published var name: String = ""
    @Published var password: String = ""
    @Published var passwordCheck: String = ""
    @Published var phone: String = ""
    @Published var school: String = ""
    
    // Policies
    @Published var agreeUsage: Bool = false
    @Published var agreePersonal: Bool = false
    @Published var agreeEventNotice: Bool = false
    
    // MARK: - Validation Output
    
    @Published var isValid: Bool = false
    
    @Published var nameAlert: String = ""
    @Published var schoolAlert: String = ""
    @Published var emailAlert: String = ""
    @Published var passwordAlert: String = ""
    @Published var agreeAlert: String = ""

    private var cancelBag = CancelBag()
    
    init() {
        isNameEmptyPublisher
            .receive(on: RunLoop.main)
            .map { usernameEmpty in
                usernameEmpty ? "Username must not be empty" : ""
            }
            .assign(to: \.nameAlert, on: self)
            .store(in: cancelBag)
        
        isSchoolEmptyPublisher
            .receive(on: RunLoop.main)
            .map { schoolEmpty in
                schoolEmpty ? "School must be selected" : ""
            }
            .assign(to: \.schoolAlert, on: self)
            .store(in: cancelBag)
        
        isEmailValidPublisher
            .receive(on: RunLoop.main)
            .map { emailCheck in
                switch emailCheck {
                case .empty: return "Email must not be empty"
                case .noFulfilRule: return "Check your email format"
                default: return ""
                }
            }
            .assign(to: \.emailAlert, on: self)
            .store(in: cancelBag)
        
        isPasswordValidPublisher
            .receive(on: RunLoop.main)
            .map { passwordCheck in
                switch passwordCheck {
                case .empty: return "Password must not be empty"
                case .noMatch: return "Passwords doesn't matches"
                case .noFulfilRules: return "Check your password format"
                default: return ""
                }
            }
            .assign(to: \.passwordAlert, on: self)
            .store(in: cancelBag)
        
        isRequiredPoliciesCheckedPublisher
            .receive(on: RunLoop.main)
            .map { requiredPoliciesCheck in
                requiredPoliciesCheck ? "" : "Required policies must be checked"
            }
            .assign(to: \.agreeAlert, on: self)
            .store(in: cancelBag)
        
        isFormValidPublisher
            .receive(on: RunLoop.main)
            .map { isValid in
                isValid ? true : false
            }
            .assign(to: \.isValid, on: self)
            .store(in: cancelBag)
    }
    
    func clearAll() {
        name = ""
        school = ""
        email = ""
        password = ""
        passwordCheck = ""
        agreeUsage = false
        agreePersonal = false
        agreeEventNotice = false
        
        isValid = false
        nameAlert = ""
        schoolAlert = ""
        emailAlert = ""
        passwordAlert = ""
        agreeAlert = ""
    }
    
    func agreeAll(state: Bool) {
        agreePersonal = state
        agreeUsage = state
        agreeEventNotice = state
    }
    
    // MARK:- Name and School Validation
    
    enum UserDataStatus {
        case valid
        case nameEmpty
        case schoolEmpty
    }
    
    private var isNameEmptyPublisher: AnyPublisher<Bool, Never> {
        $name
          .debounce(for: 0.8, scheduler: RunLoop.main)
          .removeDuplicates()
          .map { name in
            return name == ""
          }
          .eraseToAnyPublisher()
    }
    
    private var isSchoolEmptyPublisher: AnyPublisher<Bool, Never> {
        $school
          .debounce(for: 0.8, scheduler: RunLoop.main)
          .removeDuplicates()
          .map { school in
            return school == ""
          }
          .eraseToAnyPublisher()
    }
    
    private var isNameAndSchoolValidPublisher: AnyPublisher<UserDataStatus, Never> {
        Publishers.CombineLatest(isNameEmptyPublisher, isSchoolEmptyPublisher)
            .map { nameIsEmpty, schoolIsEmpty in
                if (nameIsEmpty) {
                  return .nameEmpty
                }
                else if (schoolIsEmpty) {
                    return .schoolEmpty
                }
                else {
                  return .valid
                }
            }.eraseToAnyPublisher()
    }
    
    // MARK:- Email Validation
    
    enum EmailStatus {
        case valid
        case empty
        case noFulfilRule
    }
    
    private var isEmailEmptyPublisher: AnyPublisher<Bool, Never> {
        $email
          .debounce(for: 0.8, scheduler: RunLoop.main)
          .removeDuplicates()
          .map { email in
            return email == ""
          }
          .eraseToAnyPublisher()
    }
    
    private var isEmailFulfilRulePublisher: AnyPublisher<Bool, Never> {
        $email
          .debounce(for: 0.8, scheduler: RunLoop.main)
          .removeDuplicates()
          .map { input in
            let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: input)
          }
          .eraseToAnyPublisher()
      }
    
    private var isEmailValidPublisher: AnyPublisher<EmailStatus, Never> {
        Publishers.CombineLatest(isEmailEmptyPublisher, isEmailFulfilRulePublisher)
            .map { emailIsEmpty, emailFulfilRules in
                if (emailIsEmpty) {
                  return .empty
                }
                else if (!emailFulfilRules) {
                    return .noFulfilRule
                }
                else {
                  return .valid
                }
            }.eraseToAnyPublisher()
    }
    
    
    // MARK: - PasswordRules
    /**
            PASSWORD RULES
                1. At least 8 characters
                2. contains 1 letter, 1 number, 1 special character
     */
    enum PasswordStatus {
        case valid
        case empty
        case noMatch
        case noFulfilRules
      }
    
    private var isPasswordFulfilRulesPublisher: AnyPublisher<Bool, Never> {
        $password
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { password in
                let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,}$"
                let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
                return passwordPred.evaluate(with: password)
            }
            .eraseToAnyPublisher()
    }
    
    private var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> {
        $password
          .debounce(for: 0.8, scheduler: RunLoop.main)
          .removeDuplicates()
          .map { password in
            return password == ""
          }
          .eraseToAnyPublisher()
      }
    
    private var isPasswordCheckEmptyPublisher: AnyPublisher<Bool, Never> {
        $passwordCheck
          .debounce(for: 0.8, scheduler: RunLoop.main)
          .removeDuplicates()
          .map { passwordCheck in
            return passwordCheck == ""
          }
          .eraseToAnyPublisher()
      }
    
    private var arePasswordEqualPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($password, $passwordCheck)
              .debounce(for: 0.2, scheduler: RunLoop.main)
              .map { password, passwordCheck in
                return password == passwordCheck
              }
              .eraseToAnyPublisher()
      }
    
    private var isPasswordValidPublisher: AnyPublisher<PasswordStatus, Never> {
        Publishers.CombineLatest3(isPasswordEmptyPublisher, arePasswordEqualPublisher, isPasswordFulfilRulesPublisher)
            .map { passwordIsEmpty, passwordsAreEqual, passwordFulfilRules in
                if (passwordIsEmpty) {
                  return .empty
                }
                else if (!passwordsAreEqual) {
                  return .noMatch
                }
                else if (!passwordFulfilRules) {
                  return .noFulfilRules
                }
                else {
                  return .valid
                }
            }.eraseToAnyPublisher()
    }
    
    
    // MARK: - Policies Checker
    
    private var isRequiredPoliciesCheckedPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($agreeUsage, $agreePersonal)
          .debounce(for: 0.8, scheduler: RunLoop.main)
          .map { usage, personal in
            return usage == true && personal == true
          }
          .eraseToAnyPublisher()
      }
    
    // MARK: - Total Validation
    
    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest4(isEmailValidPublisher, isPasswordValidPublisher, isNameAndSchoolValidPublisher, isRequiredPoliciesCheckedPublisher)
          .map { emailIsValid, passwordIsValid, restFormValid, isRequiredPoliciesChecked in
            if (restFormValid != .valid) { return false }
            return (emailIsValid == .valid) && (passwordIsValid == .valid) && isRequiredPoliciesChecked
          }.eraseToAnyPublisher()
      }
    
    
}

