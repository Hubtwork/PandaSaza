//
//  ImagePickerView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/09.
//

import SwiftUI
import Combine
import YPImagePicker

final class ImagePicker: ObservableObject {
    static let shared : ImagePicker = ImagePicker()
    private init() {}  //force using the singleton: ImagePicker.shared
    let view = ImagePicker.View()
    let coordinator = ImagePicker.Coordinator()
    
    // Bindable Object part
    let willChange = PassthroughSubject<UIImage, Never>()
    @Published var image: UIImage? {
        didSet {
            if image != nil {
                willChange.send(image!)
            }
        }
    }
}

extension ImagePicker {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        // UIImagePickerControllerDelegate
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            ImagePicker.shared.image = uiImage
            picker.dismiss(animated:true)
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated:true)
        }
    }
    
    struct View: UIViewControllerRepresentable {
        func makeCoordinator() -> Coordinator {
            ImagePicker.shared.coordinator
        }
        func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker.View>) -> UIImagePickerController {
            let picker = UIImagePickerController()
            picker.delegate = context.coordinator
            
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "NanumSquareRoundR", size: 20)!]
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
            UINavigationBar.appearance().shadowImage = UIImage()
            UINavigationBar.appearance().backgroundColor = .white
            UINavigationBar.appearance().isTranslucent = true
            
            return picker
        }
        func updateUIViewController(_ uiViewController: UIImagePickerController,
                                    context: UIViewControllerRepresentableContext<ImagePicker.View>) {
        }
    }
}

class PSImagePicker: ObservableObject {
    static let shared: PSImagePicker = PSImagePicker()
    var selectedItems = [YPMediaItem]()
    
    let view = PSImagePicker.View()
    
    let willChange = PassthroughSubject<[ProductItemImage], Never>()
    @Published var images: [ProductItemImage] = [] {
        didSet{
            if !images.isEmpty {
                willChange.send(images)
            }
        }
    }
}


extension PSImagePicker{
    
    struct View: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> YPImagePicker {
            // PSImagePicker.shared.images.removeAll()
            var config = YPImagePickerConfiguration()
            
            config.startOnScreen = YPPickerScreen.library
            config.shouldSaveNewPicturesToAlbum = false
            
            config.screens = [.library, .photo]
            
            config.hidesStatusBar = true
            config.hidesBottomBar = false
            
            // config.library.preselectedItems = []
            config.wordings.libraryTitle = "갤러리"
            config.wordings.cameraTitle = "카메라"
            config.wordings.next = "다음"
            config.wordings.filter = "필터"
            config.wordings.cancel = "취소"
            
            config.library.mediaType = .photo
            config.library.maxNumberOfItems = 10
            config.library.defaultMultipleSelection = true
            config.library.preSelectItemOnMultipleSelection = true
            config.library.skipSelectionsGallery = true
            config.library.preselectedItems = PSImagePicker.shared.selectedItems
            
            config.showsPhotoFilters = false
            
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 17)]
            
            let picker = YPImagePicker(configuration: config)
            picker.didFinishPicking { [unowned picker] items, cancelled in
                PSImagePicker.shared.images.removeAll()
                for item in items {
                    switch item {
                    case .photo(let photo):
                        PSImagePicker.shared.images.append(ProductItemImage(photo: photo.image))
                    case .video(let video):
                        print(video)
                    }
                }
                PSImagePicker.shared.selectedItems = items
                picker.dismiss(animated: true, completion: nil)
            }
            
            return picker
        }
        func updateUIViewController(_ uiViewController: YPImagePicker, context: UIViewControllerRepresentableContext<PSImagePicker.View>) {
            
        }
    }
}
