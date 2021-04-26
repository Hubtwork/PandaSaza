//
//  SignUp_Email.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/08.
//

import SwiftUI

struct SignUp_Email: View {
    
    @Environment(\.injected) private var injected: DIContainer
    @Environment(\.presentationMode) private var presentation
    
    
    @ObservedObject private var validation: SignUpValidationModel = SignUpValidationModel()
    
    @State private var schoolSearch: SchoolSearch = SchoolSearch()
    
    @State private var authCodeSent: Bool = false
    
    @State private var signPhase: Int = 1
    private var signTitle: [String] = ["Phone Validation", "School Validation", "Locale Validation", "Language Validation"]
    
    var body: some View {
        content
            .onAppear {
                self.loadSchools()
            }
    }
}

//MARK: - Screens

private extension SignUp_Email {
    
    var content: some View {
        ZStack {
            
            ScrollView {
                VStack {
                    switch self.signPhase {
                    case 0: self.phoneValidation
                    case 1: self.schoolValidation
                    default: self.phoneValidation
                    }
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
            HintTextField(text: $validation.phone, hint: "Phone Number ( Numbers Only )", isNumber: true)
            
            Button(action: {
                self.authSMS_sent()
            }) {
                RoundedButton(textColor: .white,
                              bgColor: !$validation.validPhone.wrappedValue ? Color.black.opacity(0.2) : Color.black.opacity(0.6),
                              width: .infinity, height: 60, strokeColor: .black, strokeWidth: 0, radius: 5, text: "Send Auth SMS", textSize: 22)
                    .padding(.horizontal, 20)
            }.disabled(!$validation.validPhone.wrappedValue)
            
            if authCodeSent {
                VStack(alignment: .leading, spacing: 5) {
                    HintTextField(text: $validation.phoneAuthCode, hint: "Auth Code ( Numbers Only )", isNumber: true)
                    Text("Please don't share it with others")
                        .font(.custom("NanumGothic", size: 18))
                    
                    RoundedButton(textColor: .white,
                                  bgColor: $validation.phoneAuthCode.wrappedValue.isEmpty ? Color.black.opacity(0.2) : Color.black.opacity(0.6),
                                  width: .infinity, height: 60,
                                  strokeColor: .black, strokeWidth: 0, radius: 5, text: "Check Auth SMS", textSize: 22)
                        .disabled($validation.phoneAuthCode.wrappedValue.isEmpty)
                        .padding(.top, 20)
                }.padding(.top, 20)
            }
        }
        .padding(.top, 30)
        .padding(.horizontal, 20)
        .animation(.spring())
    }
    
    var schoolValidation: some View {
        VStack(spacing: 20) {
            SearchBar(searchText: $schoolSearch.searchText,
                      hintText: "Search your school")
                .padding(.bottom, 20)
            
            Button(action: { loadSchools() }) {
                Text("버튼")
            }
            
            switch schoolSearch.filtered {
            case .notRequested: Text("로딩안됨")
            case .isLoading(_, _): Text("로딩중")
            case .loaded(_): Text("로딩됨")
            default: Text("오미")
            }
                
        }
        .padding(.top, 30)
        .padding(.horizontal, 20)
    }
    
    var signToolBar: some View {
        VStack(spacing: 0) {
            ZStack {
                self.toolBarTitle(title: signTitle[signPhase])
                
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

// MARK:- Actions
private extension SignUp_Email {
    
    func authSMS_sent() {
        // api call
        
        // if vaild
        authCodeSent = true
    }
    
    func authSMS_check() {
        // api call
        
        // if valid
        self.signPhase += 1
    }
    
    func phase_back() {
        if self.signPhase == 0 { presentation.wrappedValue.dismiss() }
        else { self.signPhase -= 1 }
    }
    
    func loadSchools() {
        injected.interactors.staticInteractor.getSchools(schools: $schoolSearch.allSchools)
    }
    
}

struct SignUp_Email_Previews: PreviewProvider {
    static var previews: some View {
        SignUp_Email()
            .inject(AppEnvironment.bootstrap().container)
    }
}
