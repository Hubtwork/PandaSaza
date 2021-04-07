//
//  SignInValidation.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/02.
//

import Foundation
import Combine

class SignInValidation: ObservableObject {
    
    // MARK: - Form Input
    
    // values
    @Published var email: String = ""
    @Published var password: String = ""
    
    // MARK: - Validation Output
    
    @Published var isValid: Bool = false

    @Published var emailAlert: String = ""
    @Published var passwordAlert: String = ""
    
    private let cancelBag = CancelBag()
    
    init() {
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
        
        isPasswordEmptyPublisher
            .receive(on: RunLoop.main)
            .map { passwordEmpty in
                passwordEmpty ? "Password must not be empty" : ""
            }
            .assign(to: \.passwordAlert, on: self)
            .store(in: cancelBag)
        
        isFormValidPublisher
            .receive(on: RunLoop.main)
            .map { isValid in
                isValid ? true : false
            }
            .assign(to: \.isValid, on: self)
            .store(in: cancelBag)
    }
    
    // MARK: - SignIn Request
    
    
    
    func clearAll() {
        email = ""
        password = ""
        
        isValid = false
        emailAlert = ""
        passwordAlert = ""
    }
    
    
    // MARK: - Email Checker
    
    enum EmailStatus {
        case valid
        case empty
        case noFulfilRule
    }
    
    private var isEmailEmptyPublisher: AnyPublisher<Bool, Never> {
        $email
          .debounce(for: 0.2, scheduler: RunLoop.main)
          .removeDuplicates()
          .map { email in
            return email == ""
          }
          .eraseToAnyPublisher()
    }
    
    private var isEmailFulfilRulePublisher: AnyPublisher<Bool, Never> {
        $email
          .debounce(for: 0.2, scheduler: RunLoop.main)
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
    
    // MARK: - Password Checker
    
    private var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> {
        $password
          .debounce(for: 0.2, scheduler: RunLoop.main)
          .removeDuplicates()
          .map { password in
            return password == ""
          }
          .eraseToAnyPublisher()
      }
    
    
    // MARK: - Total Validation
    
    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isEmailValidPublisher, isPasswordEmptyPublisher)
          .map { emailIsValid, passwordIsEmpty in
            return (emailIsValid == .valid) && !passwordIsEmpty
          }.eraseToAnyPublisher()
      }
}
