//
//  ProfileRegistration.swift
//  Panda-Saza
//
//  Created by 허재 on 2021/05/13.
//

import SwiftUI

struct ProfileRegistration: View {
    
    
    // Registration Info
    let phoneNumber: String
    let school: String
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

extension ProfileRegistration {
    
    var content: some View {
        ZStack {
            self.profileImageView
        }
    }
    
    var profileImageView: some View {
        VStack {
            
        }
    }
}

struct ProfileRegistration_Previews: PreviewProvider {
    static var previews: some View {
        ProfileRegistration(phoneNumber: "01075187260", school: "Dongguk Univ.")
    }
}
