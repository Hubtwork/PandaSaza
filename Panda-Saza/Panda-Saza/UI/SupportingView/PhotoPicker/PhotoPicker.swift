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
    // @Binding var isPresented: Bool
    // Multi Mode ( single : 1 , multi : ~ 10 )
    var multiMode: Bool
    
    @ObservedObject var mediaItems: PickedMediaItems
    var didFinishPicking: (_ didSelectItems: Bool) -> Void
    
    //@Binding var images: [UIImage]
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        // var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        var configuration = PHPickerConfiguration()
        configuration.filter = .any(of: [.images])
        if multiMode { configuration.selectionLimit = 10 - mediaItems.items.count }
        else { configuration.selectionLimit = 1 }
        configuration.preferredAssetRepresentationMode = .current
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(with: self)
    }
    
    // Use a Coordinator to act as your PHPickerViewControllerDelegate
    class Coordinator: PHPickerViewControllerDelegate {
      
        private let photoPicker: PhotoPicker
        
        init(with photoPicker: PhotoPicker) {
            self.photoPicker = photoPicker
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            photoPicker.didFinishPicking(!results.isEmpty)
                        
            guard !results.isEmpty else {
                return
            }
            
            for result in results {
                let itemProvider = result.itemProvider
                
                guard let typeIdentifier = itemProvider.registeredTypeIdentifiers.first,
                      let utType = UTType(typeIdentifier)
                else { continue }
                
                if utType.conforms(to: .image) {
                    self.getPhoto(from: itemProvider, isLivePhoto: false)
                } else if utType.conforms(to: .movie) {
                    self.getVideo(from: itemProvider, typeIdentifier: typeIdentifier)
                } else {
                    self.getPhoto(from: itemProvider, isLivePhoto: true)
                }
            }
            // photoPicker.isPresented = false // Set isPresented to false because picking has finished.
        }
        
        private func getPhoto(from itemProvider: NSItemProvider, isLivePhoto: Bool) {
            let objectType: NSItemProviderReading.Type = !isLivePhoto ? UIImage.self : PHLivePhoto.self
            
            if itemProvider.canLoadObject(ofClass: objectType) {
                itemProvider.loadObject(ofClass: objectType) { object, error in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    
                    if !isLivePhoto {
                        if let image = object as? UIImage {
                            DispatchQueue.main.async {
                                self.photoPicker.mediaItems.append(item: PhotoPickerModel(with: image))
                            }
                        }
                    } else {
                        if let livePhoto = object as? PHLivePhoto {
                            DispatchQueue.main.async {
                                self.photoPicker.mediaItems.append(item: PhotoPickerModel(with: livePhoto))
                            }
                        }
                    }
                }
            }
        }
        
        private func getVideo(from itemProvider: NSItemProvider, typeIdentifier: String) {
            itemProvider.loadFileRepresentation(forTypeIdentifier: typeIdentifier) { url, error in
                if let error = error {
                    print(error.localizedDescription)
                }
                
                guard let url = url else { return }
                
                let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
                guard let targetURL = documentsDirectory?.appendingPathComponent(url.lastPathComponent) else { return }
                
                do {
                    if FileManager.default.fileExists(atPath: targetURL.path) {
                        try FileManager.default.removeItem(at: targetURL)
                    }
                    
                    try FileManager.default.copyItem(at: url, to: targetURL)
                    
                    DispatchQueue.main.async {
                        self.photoPicker.mediaItems.append(item: PhotoPickerModel(with: targetURL))
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
