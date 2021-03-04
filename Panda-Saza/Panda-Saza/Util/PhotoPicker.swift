//
//  PhotoPicker.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/04.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    
    // Modal toggle
    @Binding var isPresented: Bool
    // Multi Mode ( single : 1 , multi : ~ 10 )
    var multiMode: Bool
    
    @Binding var images: [UIImage]
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        if multiMode { configuration.selectionLimit = 10 }
        else { configuration.selectionLimit = 1 }
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // Use a Coordinator to act as your PHPickerViewControllerDelegate
    class Coordinator: PHPickerViewControllerDelegate {
      
        private let parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.images.removeAll()
            
            // unpack the selected items
            for image in results {
                if image.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    image.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] newImage, error in
                    if let error = error {
                        print("Load Failed \(error.localizedDescription)")
                    } else if let image = newImage as? UIImage {
                        self?.parent.images.append(image)
                        /// s3 Update Function
                        // let data = image.pngData()
                        }
                    }
                } else {
                    print("Load Failed")
                }
            }
            
            parent.isPresented = false // Set isPresented to false because picking has finished.
        }
    }
}
