//
//  CircleImageView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/25.
//

import SwiftUI

struct CircleImageView: View {
    
    private let imageString: String?
    private let uiImage: UIImage?
    
    init(imageString: String) {
        self.imageString = imageString
        self.uiImage = nil
    }
    
    init(uiImage: UIImage) {
        self.imageString = nil
        self.uiImage = uiImage
    }

    var body: some View {
        VStack {
            if imageString != nil {
                ImageView(withURL: imageString!, isComingFromHomepage: false)
                    .scaledToFill()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 0.1))
                    .shadow(radius: 1)
            }
            else {
                Image(uiImage: uiImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaledToFill()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 0.1))
                    .shadow(radius: 1)
            }
        }
    }
}

struct CircleImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircleImageView(imageString: "gucci_01")
    }
}
