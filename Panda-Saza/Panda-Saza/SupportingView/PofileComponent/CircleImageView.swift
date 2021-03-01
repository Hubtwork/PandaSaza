//
//  CircleImageView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/25.
//

import SwiftUI

struct CircleImageView: View {
    
    private let imageString: String
    
    init(imageString: String) {
        self.imageString = imageString
    }
    
    var body: some View {
        VStack {
            ImageView(withURL: imageString, isComingFromHomepage: false)
                .scaledToFill()
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 0.1))
                .shadow(radius: 1)
        }
    }
}

struct CircleImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircleImageView(imageString: "gucci_01")
    }
}
