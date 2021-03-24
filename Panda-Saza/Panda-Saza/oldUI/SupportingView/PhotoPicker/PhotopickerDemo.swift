//
//  PhotopickerDemo.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/09.
//

import SwiftUI

struct PhotoPickerDemo: View {
    
    /// Photo Relative
    @State private var showSheet = false
    @ObservedObject var mediaItems = PickedMediaItems()
    
    var body: some View {
            VStack(spacing: 0){
                Divider()
                    .background(Color.black)
                ScrollView {
                    self.itemPhotoView
                    Divider()
                }.padding(.horizontal, 15)
                .padding(.top, 10)
            }.sheet(isPresented: $showSheet, content: {
            PhotoPicker(multiMode: true, mediaItems: mediaItems) { didSelectItem in
                // Handle didSelectItems value here...
                showSheet = false
            }
        })
    }
}

extension PhotoPickerDemo {
    var itemPhotoView: some View {
        HStack(alignment: .center) {
            Button(action: {
                showSheet = true
            }) {
                VStack(spacing: 5) {
                    Image(systemName: "camera.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22)
                    Text(String(mediaItems.items.count) + " / 10")
                        .font(.body)
                }
                .frame(width: 80, height: 80)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
            }.foregroundColor(.black)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 5){
                    ForEach(mediaItems.items, id: \.id) { item in
                        if item.mediaType == .photo {
                            Image(uiImage: item.photo ?? UIImage())
                                .resizable()
                                .frame(width: 70, height: 70)
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
                        }
                    }
                }
                .padding(10)
            }
            
        }.padding(.vertical, 10)
        .padding(.horizontal, 20)
    }
    
    fileprivate func getMediaImageName(using item: PhotoPickerModel) -> String {
        switch item.mediaType {
            case .photo: return "photo"
            case .video: return "video"
            case .livePhoto: return "livephoto"
        }
    }
}
