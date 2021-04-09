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
    
    @State private var signPhase: Int = 0
    private var signTitle: [String] = ["School Validation", "Locale Validation", "Language Validation"]
    
    var body: some View {
        content
    }
}

//MARK: - Screens

private extension SignUp_Email {
    
    var content: some View {
        ZStack {
            
            
            self.signToolBar
            
            .navigationBarHidden(true)
        }
    }
    
    
    var signToolBar: some View {
        VStack(spacing: 0) {
            ZStack {
                self.toolBarTitle(title: signTitle[signPhase])
                
                self.toolBarButton
            }
            .padding(.vertical, 10)
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
    
    func phase_back() {
        if self.signPhase == 0 { presentation.wrappedValue.dismiss() }
        else { self.signPhase -= 1 }
    }
    
}

struct SignUp_Email_Previews: PreviewProvider {
    static var previews: some View {
        SignUp_Email().inject(AppEnvironment.bootstrap().container)
    }
}
