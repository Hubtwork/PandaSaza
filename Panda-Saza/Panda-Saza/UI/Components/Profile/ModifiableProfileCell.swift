//
//  ProfileCell.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/13.
//

import SwiftUI

struct ModifiableProfileCell: View {
    
    
    
    var body: some View {
        self.content
    }
}

private extension ModifiableProfileCell {
    
    var content: some View {
        VStack {
            modifiableProfileImage
        }
    }
    
    var modifiableProfileImage: some View {
        ProfileImageView(webImageURL: nil)
            .frame(width: 100, height: 100)
    }
}

struct ProfileCell_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ModifiableProfileCell()
        }
    }
}
