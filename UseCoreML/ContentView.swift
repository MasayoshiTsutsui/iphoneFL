//
//  ContentView.swift
//  UseCoreML
//
//  Created by Masayoshi Tsutsui on 2023/05/03.
//
import SwiftUI

struct ContentView: View {

    @State private var selectedImage: UIImage? = nil // UIImage? to store the selected image
    @State private var showImagePicker: Bool = false
    @State private var userId: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("User ID")) {
                    TextField("Enter User ID", text: $userId)
                }
                
                Section(header: Text("Image")) {
                    Button(action: {
                        showImagePicker = true
                    }) {
                        Text("Upload Image")
                    }
                }

            }
            .navigationTitle("Send to Server")
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                ImagePicker(selectedImage: $selectedImage)
            }
        }
    }
    
    func loadImage() {
        if let image = selectedImage {
            print("Selected image: \(image)")
        } else {
            print("No image selected")
        }
        print("User ID: \(userId)")
        ConfirmationViewController().requestWith(image: selectedImage!, userId: userId)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(selectedImage: $selectedImage)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        @Binding var selectedImage: UIImage?
        
        init(selectedImage: Binding<UIImage?>) {
            _selectedImage = selectedImage
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                self.selectedImage = selectedImage
            }
            
            picker.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    }
}
