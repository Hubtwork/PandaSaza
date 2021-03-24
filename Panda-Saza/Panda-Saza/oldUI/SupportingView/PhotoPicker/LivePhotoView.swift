//
//  LivePhotoView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/09.
//

import SwiftUI
import PhotosUI

struct LivePhotoView: UIViewRepresentable {
    typealias UIViewType = PHLivePhotoView
    
    var livePhoto: PHLivePhoto
    
    func makeUIView(context: Context) -> PHLivePhotoView {
        let livePhotoView = PHLivePhotoView()
        livePhotoView.livePhoto = livePhoto
        
        // Enable the following optionally to see live photo
        // playing back when it appears.
        // livePhotoView.startPlayback(with: .hint)
        
        return livePhotoView
    }
    
    func updateUIView(_ uiView: PHLivePhotoView, context: Context) {
        
    }
}
