//
//  CircularImageView.swift
//  Panda-Saza
//
//  Created by 허재 on 2021/05/13.
//

import SwiftUI

struct ModifiableProfileImageView: View {
    
    private let webImageURL: String?
    
    @State var showSheet: Bool = false
    @State var showImagePicker: Bool = false
    @State var images: [Image] = []
    
    init(webImageURL: String? = nil){
        self.webImageURL = webImageURL
    }
    
    var body: some View {
        GeometryReader { geometry in
            Button(action: {
                showSheet = true
            }) {
            ZStack {
                    if images.isEmpty {
                        basicProfileImage
                            /// It seems to Circle Image in frame, usually fit to height frame not width
                            .frame(width: geometry.size.width,
                                   height: geometry.size.height)
                            .background(Color.white.opacity(0))
                    } else {
                        circleClippedImage
                            /// It seems to Circle Image in frame, usually fit to height frame not width
                            .frame(width: geometry.size.width,
                                   height: geometry.size.height)
                    }
                    cameraButton
                        .frame(width: geometry.size.width * 0.5,
                               height: geometry.size.height * 0.5)
                        .offset(x: geometry.size.width * 0.45,
                                y: geometry.size.height * 0.2)
                }
            }
            .actionSheet(isPresented: $showSheet) {
                ActionSheet(title: Text("Select Profile"),
                            buttons: [
                                .default(
                                    Text("Select from album"),
                                    action: {
                                        showImagePicker = true
                                    }
                                ),
                                .destructive(
                                    Text("Delete Profile Image"),
                                    action: {
                                        $images.wrappedValue = []
                                    }
                                ),
                                .cancel(Text("Cancel"))])
            }
            .fullScreenCover(isPresented: $showImagePicker,
                              content: {
                BSImagePickerViewRepresentable(images: $images)
            })
        }
    }
}

private extension ModifiableProfileImageView {
    
    var basicProfileImage: some View {
        ZStack {
            Image("man-user")
                .resizable()
                .opacity(0.7)
                .padding(5)
                .background(Color.gray.opacity(0.3))
                .clipShape(Circle())
        }
    }
    
    var cameraButton: some View {
        Image(systemName: "camera.fill")
            .resizable()
            .foregroundColor(Color.black.opacity(0.4))
            .scaledToFit()
            .padding(8)
            .background(Color.white)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.black.opacity(0.4), lineWidth: 1)
                    .foregroundColor(Color.white.opacity(0))
            )
    }
    
    var circleClippedImage: some View {
        images[0]
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
    }
}


struct ModifiableProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Circle()
                .foregroundColor(Color.white)
            ModifiableProfileImageView()
                .frame(width: 100, height: 100)
        }
        .frame(width: 300, height: 300)
        .background(Color.black.opacity(0.1))
    }
}
