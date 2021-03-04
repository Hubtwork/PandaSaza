//
//  ProfileChangeView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/04.
//

import SwiftUI

struct ProfileChangeView: View {
    
    @Environment(\.presentationMode) var presentation
    var profileImageURL: String
    @Binding var profileName: String
    
    @State private var photoPickerIsPresented = false
    @State var selectedImage: [UIImage] = []
    
    var body: some View {
        layout
            .navigationBarHidden(true)
    }
}

extension ProfileChangeView {
    
    var layout: some View {
        VStack(spacing: 0){
            titleBar
            Divider()
            
            profileImageView
                .padding(.top, 30)
                .padding(.bottom, 10)
            profileNameView
                .padding(.top, 20)
            introduceText
                .padding(.top, 10)
            
            ScrollView {
                ForEach(selectedImage, id: \.self) { uiImage in
                  Image(uiImage: uiImage)
                    .resizable()
                    .frame(height: 250, alignment: .center)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding(10)
                }
                .padding()
              }
            
            Spacer()
        }.edgesIgnoringSafeArea(.bottom)
        .sheet(isPresented: $photoPickerIsPresented) {
            PhotoPicker(isPresented: $photoPickerIsPresented, multiMode: false, images: $selectedImage)
          }
    }
    
    var profileImageView: some View {
        HStack {
            Spacer()
            Button(action: {
                photoPickerIsPresented.toggle()
            }) {
                CircleImageView(imageString: profileImageURL)
                    .frame(width:UIScreen.screenWidth / 4, height: UIScreen.screenWidth / 4)
                    .overlay(Circle().stroke(Color.black, lineWidth: 1).shadow(radius: 3))
                    .overlay(profileImageBadge)
            }
            Spacer()
        }
    }
    
    var profileImageBadge: some View {
        ZStack {
            Image(systemName:"plus.circle.fill")
                .resizable()
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .frame(width: UIScreen.screenWidth / 12, height: UIScreen.screenWidth / 12)
                .position(x: UIScreen.screenWidth / 4.5, y: UIScreen.screenWidth / 4.5)
        }
    }
    
    var profileNameView: some View {
        HStack {
            Spacer()
            TextField("", text: $profileName)
                .padding(.vertical, 10)
                .foregroundColor(Color.black)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
                .font(.title2)
                .multilineTextAlignment(.center)
                .frame(width: UIScreen.screenWidth * 0.8)
            Spacer()
        }
    }
    
    var introduceText: some View {
        HStack {
            Spacer()
            Text("프로필 사진과 닉네임을 수정해주세요")
                .font(.body)
            Spacer()
        }
    }
    
    var titleBar: some View {
        ZStack {
            HStack {
                Button(action: { presentation.wrappedValue.dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(Font.system(size: UIScreen.screenWidth / 15))
                }.foregroundColor(.black)
                Spacer()
                Text("완료")
                    .font(.title2)
                    
            }.padding(.vertical, 10)
            .padding(.horizontal, 10)
            
            HStack {
                Spacer()
                Text("프로필 수정")
                    .font(.title2)
                    .bold()
                Spacer()
            }.padding(.vertical, 10)
        }
    }
}

struct ProfileChangeView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileChangeView(profileImageURL:  "https://file3.instiz.net/data/cached_img/upload/2019/09/21/22/f5ce7f9944770d1c575d9ada78c97b65.jpg", profileName: .constant("정동민"))
    }
}
