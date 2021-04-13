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
    
    @State private var response: Loadable<JsonSmsValidation> = .notRequested
    
    @ObservedObject private var validation: PhoneValidationModel = PhoneValidationModel()
    
    @State private var authCodeSent: Bool = false
    @State private var isAuthComplete: Bool = false
    @State private var authFailedAlert: Bool = false
    
    var body: some View {
        content
            .foregroundColor(Color.black)
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .alert(isPresented: $authFailedAlert) {
                Alert(title: Text(""),
                      message: Text("Authentification Code unmatched. Check Again."),
                      dismissButton: .default(Text("OK")))
            }
            .onChange(of: response) {
                switch response {
                case let .loaded(response):
                    print(response)
                    self.authCodeSent.toggle()
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
            /// Empty Navigation LInk
            NavigationLink(
                destination: SchoolValidationView(phoneNumber: $validation.phone.wrappedValue),
                isActive: $isAuthComplete) {
                    EmptyView()
                }
            ScrollView {
                VStack {
                    self.phoneValidation
                    Spacer()
                }
            }
            .padding(.top, 60)  // consider toolbar height
            
            self.signToolBar
            
            .navigationBarHidden(true)
        }
    }
    
    var phoneValidation: some View {
        VStack(spacing: 20) {
            PhoneTextField(text: $validation.phone,
                           hint: "Phone Number ( Numbers Only )")
            
            Button(action: {
                self.authSMS_sent()
            }) {
                RoundedButton(textColor: .white,
                              bgColor: !$validation.validPhone.wrappedValue ? Color.black.opacity(0.2) : Color.black.opacity(0.6),
                              width: .infinity, height: 45, strokeColor: .black, strokeWidth: 0, radius: 5, text: "Send Auth SMS", textSize: 18)
            }.disabled(!$validation.validPhone.wrappedValue)
            
            if authCodeSent {
                VStack(alignment: .leading, spacing: 5) {
                    PhoneTextField(text: $validation.phoneAuthCode,
                                   hint: "Auth Code ( Numbers Only )",
                                   isAuth: true)
                    Text("Please don't share it with others")
                        .font(.custom("NanumGothic", size: 18))
                    Button(action: { self.authSMS_check() }) {
                        RoundedButton(textColor: .white,
                                      bgColor: $validation.phoneAuthCode.wrappedValue.isEmpty ? Color.black.opacity(0.2) : Color.black.opacity(0.6),
                                      width: .infinity, height: 45,
                                      strokeColor: .black, strokeWidth: 0, radius: 5, text: "Check Auth SMS", textSize: 18)
                            .disabled($validation.phoneAuthCode.wrappedValue.isEmpty)
                            .padding(.top, 20)
                    }
                }.padding(.top, 20)
            }
        }
        .padding(.top, 30)
        .padding(.horizontal, 30)
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
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.black)
            }
            Spacer()
        }
        .padding(.leading, 30)
    }
    
    func toolBarTitle(title: String) -> some View {
        HStack {
            Spacer()
            
            Text(title)
                .font(.custom("NanumGothicBold", size: 22))
            
            Spacer()
        }
    }
}

// MARK:- Side Effect
private extension PhoneValidationView {
    
    func authSMS_sent() {
        // api call
        injected.interactors.signInteractor.authSMS(phone: $validation.phone.wrappedValue, response: $response)
        // if vaild
        /*
        if response.value!.success{
            authCodeSent = true
        } else {
            
        }
         */
    }
    
    func authSMS_check() {
        // get wrapped value and check
        
        // if authCode is valid and same with user input
        if Int($validation.phoneAuthCode.wrappedValue) ?? 0 == response.value!.code {
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
