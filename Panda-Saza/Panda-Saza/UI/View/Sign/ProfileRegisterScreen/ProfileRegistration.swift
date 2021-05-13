//
//  ProfileRegistration.swift
//  Panda-Saza
//
//  Created by 허재 on 2021/05/13.
//

import SwiftUI

struct ProfileRegistration: View {
    
    @Environment(\.injected) private var injected: DIContainer
    @Environment(\.presentationMode) private var presentation
    
    @State private var profileName: String = ""
    
    // Registration Info
    let phoneNumber: String
    let school: String
    
    var body: some View {
        self.content
            .padding(.horizontal, 15)
    }
}

extension ProfileRegistration {
    
    var content: some View {
        ZStack {
            self.profileView
                .padding(.top, 90)  // consider toolbar height
                .padding(.horizontal, 20)
            
            self.signToolBar
                
            .navigationBarHidden(true)
        }
    }
    
    var profileView: some View {
        VStack(spacing: 15){
            /// Profile Image
            ModifiableProfileImageView()
                .frame(width: 80, height: 80)
            /// Profile Name
            self.profileNameView
            
            Spacer()
        }
    }
    
    var profileNameView: some View {
        TextField("", text: $profileName)
            .font(.system(size: 17))
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.black, lineWidth: 1)
            )
    }
    
    var signToolBar: some View {
        VStack(spacing: 0) {
            ZStack {
                self.toolBarTitle(title: "Profile")
                
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
                    .frame(width: 15, height: 15)
                    .foregroundColor(Color.black)
            }
            Spacer()
        }
        .frame(height: 40)
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

struct ProfileRegistration_Previews: PreviewProvider {
    static var previews: some View {
        ProfileRegistration(phoneNumber: "01075187260", school: "Dongguk Univ.")
            .inject(AppEnvironment.bootstrap().container)
    }
}
