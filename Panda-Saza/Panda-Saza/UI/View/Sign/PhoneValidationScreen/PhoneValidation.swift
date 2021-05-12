//
//  PhoneValidation.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/11.
//

import SwiftUI
import Combine

struct PhoneValidationView: View {
    
    @Environment(\.injected) private var injected: DIContainer
    @Environment(\.presentationMode) private var presentation
    
    @State private var validationCode: Loadable<String> = .notRequested
    @State private var response: Loadable<JsonSMSValidation> = .notRequested
    
    @ObservedObject private var validation: PhoneValidationModel = PhoneValidationModel()
    
    @State private var authCodeSent: Bool = false
    @State private var isAuthComplete: Bool = false
    @State private var authFailedAlert: Bool = false
    @State private var phoneNumber: String = ""
    
    var body: some View {
        content
            .foregroundColor(Color.black)
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .alert(isPresented: $authFailedAlert) {
                Alert(title: Text(""),
                      message: Text("Authentification Code unmatched. Check Again."),
                      dismissButton: .default(Text("OK")))
            }
            .onChange(of: validationCode) {
                switch validationCode {
                case .loaded(_):
                    self.authCodeSent = true
                    return
                case .failed(_):
                    print("실패")
                default: print($0)
                }
            }
    }
}

// MARK:- Screens
private extension PhoneValidationView {
    
    var content: some View {
        ZStack {
            GeometryReader { geometry in
                /// Empty Navigation LInk
                NavigationLink(
                    destination: SchoolValidationView(phoneNumber: $validation.phone.wrappedValue),
                    isActive: $isAuthComplete) {
                        EmptyView()
                    }
                ScrollView {
                    VStack(spacing: 20){
                        self.phoneValidationIntroduceView
                            .frame(width: geometry.size.width * 0.7, height: geometry.size.height * 0.2)
                            .border(Color.black, width: 1)
                        self.phoneValidation
                        Spacer()
                    }.padding(.horizontal, geometry.size.width * 0.05)
                }
                .padding(.top, 60)  // consider toolbar height
                
                self.signToolBar
            
            }
            .navigationBarHidden(true)
        }
    }
    
    var phoneValidationIntroduceView: some View {
        VStack {
            Text("Images for introuce").font(.system(size: 15))
        }
    }
    
    var phoneValidation: some View {
        VStack(spacing: 15) {
            PhoneTextField(text: $validation.phone,
                           hint: "Phone Number ( Numbers Only )", textFieldHeight: 40, textSize: 15
                           )
            
            Button(action: {
                self.authSMS_sent()
            }) {
                RoundedButton(textColor: .white,
                              bgColor: !$validation.validPhone.wrappedValue ? Color.black.opacity(0.2) : Color.black.opacity(0.6),
                               height: 34, strokeColor: .black, strokeWidth: 0, radius: 5, text: "Send SMS", textSize: 17)
            }.disabled(!$validation.validPhone.wrappedValue)
            
            if authCodeSent {
                VStack(alignment: .leading, spacing: 5) {
                    PhoneTextField(text: $validation.phoneAuthCode,
                                   hint: "Auth Code ( Numbers Only )",
                                   textSize: 15,
                                   isAuth: true)
                    Text("Please don't share it with others")
                        .font(.custom("NanumGothic", size: 15))
                    Button(action: { self.authSMS_check() }) {
                        RoundedButton(textColor: .white,
                                      bgColor: $validation.phoneAuthCode.wrappedValue.isEmpty ? Color.black.opacity(0.2) : Color.black.opacity(0.6),
                                      height: 34,
                                      strokeColor: .black, strokeWidth: 0, radius: 5, text: "Check Auth SMS", textSize: 17)
                            .disabled($validation.phoneAuthCode.wrappedValue.isEmpty)
                            .padding(.top, 20)
                    }
                }.padding(.top, 20)
            }
        }
        .animation(.spring())
    }
    
    var signToolBar: some View {
        VStack(spacing: 0) {
            ZStack {
                self.toolBarTitle(title: "Phone Validation")
                
                self.toolBarButton
            }
            .padding(.vertical, 15)
            Spacer()
        }
    }
    
    var toolBarButton: some View {
        HStack{
            Button(action: {
                withAnimation {
                    presentation.wrappedValue.dismiss()
                    self.validation.clearAll()
                }
            }) {
                Image(systemName: "arrow.left")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundColor(Color.black)
            }
            Spacer()
        }
        .padding(.leading, 20)
    }
    
    func toolBarTitle(title: String) -> some View {
        HStack {
            Spacer()
            
            Text(title)
                .font(.system(size: 15))
            
            Spacer()
        }
    }
}

// MARK:- Side Effect
private extension PhoneValidationView {
    
    func authSMS_sent() {
        // api call
        injected.interactors.signInteractor.smsValidation(phone: $validation.phone.wrappedValue, validationCode: $validationCode)
    }
    
    func authSMS_check() {
        // get wrapped value and check
        if $validation.phoneAuthCode.wrappedValue == validationCode.value {
            isAuthComplete.toggle()
            self.validation.clearAll()
        } else {
            self.authFailedAlert.toggle()
        }
    }
}


struct PhoneValidationView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneValidationView()
            .inject(AppEnvironment.bootstrap().container)
    }
}
