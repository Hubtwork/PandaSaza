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
    @State private var registerButton: Bool = false
    
    // Registration Info
    let phoneNumber: String
    let school: String
    
    var body: some View {
        self.content
            .background(Color.white.edgesIgnoringSafeArea(.all))
            
    }
}

extension ProfileRegistration {
    
    var content: some View {
        ZStack {
            ScrollView {
                self.profileView
                    .padding(.top, 40)
                    .padding(.horizontal, 30)
            }.padding(.top, 50)  // consider toolbar height
            
            self.signToolBar
            
            VStack {
                Spacer()
                self.signButton
            }
            .navigationBarHidden(true)
        }.ignoresSafeArea(.all, edges: .bottom)
    }
    
    var profileView: some View {
        VStack(spacing: 30){
            /// Profile Image
            ModifiableProfileImageView()
                .frame(width: UIScreen.screenWidth*0.3,
                       height: UIScreen.screenWidth*0.3)
            /// Profile Name
            self.profileNameView
            
            Spacer()
        }
    }
    
    var profileNameView: some View {
        TextField("", text: $profileName)
            .multilineTextAlignment(.center)
            .font(.system(size: 17))
            .padding(.vertical, 15)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 1)
            )
    }
    
    var signButton: some View {
        Button(action: { }) {
            HStack {
                Spacer()
                Text("Register")
                    .foregroundColor(Color.white)
                    .font(.system(size:20))
                    .bold()
                
                Spacer()
            }
            .frame(height: 60)
            .background(Color.gray)
        }
    }
    
    var signToolBar: some View {
        VStack(spacing: 0) {
            ZStack {
                self.toolBarTitle(title: "Profile")
                
                self.toolBarButton
            }
            .background(Color.white)
            Divider()
            
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
                    .padding(.leading, 30)
            }
            Spacer()
        }
        .frame(height: 50)
    }
    
    func toolBarTitle(title: String) -> some View {
        HStack {
            Spacer()
            
            Text(title)
                .font(.system(size: 20))
                
            
            Spacer()
        }
    }
}

/// Side Effects
extension ProfileRegistration {
    
}

struct ProfileRegistration_Previews: PreviewProvider {
    static var previews: some View {
        ProfileRegistration(phoneNumber: "01075187260", school: "Dongguk Univ.")
            .inject(AppEnvironment.bootstrap().container)
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
        
        
        ProfileRegistration(phoneNumber: "01075187260", school: "Dongguk Univ.")
            .inject(AppEnvironment.bootstrap().container)
    }
}
