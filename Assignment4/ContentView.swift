//
//  ContentView.swift
//  Assignment4
//
//  Created by Peyton Scott on 4/2/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

struct ContentView: View {
    @ObservedObject private var viewModel = ContentViewModel()
    @State private var showImagePicker = false
    @State private var image: UIImage?
    @State private var notes: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.pictures) { picture in
                    PictureRowView(picture: picture)
                }
                Spacer()
                HStack {
                    TextField("Notes", text: $notes)
                        .padding()
                    Button(action: {
                        showImagePicker.toggle()
                    }) {
                        Text("Select Image")
                    }
                    .sheet(isPresented: $showImagePicker, content: {
                        ImagePicker(image: $image, sourceType: .photoLibrary)
                    })
                    Button(action: uploadImage) {
                        Text("Upload")
                    }
                }
                .padding()
            }
            .navigationTitle("Pictures")
        }
    }
    
    private func uploadImage() {
        guard let image = image, !notes.isEmpty else {
            print("Please select an image and provide notes")
            return
        }
        
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User not signed in")
            return
        }
        
        let storageRef = Storage.storage().reference().child("images/\(UUID().uuidString).jpg")
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            storageRef.putData(imageData, metadata: nil) { metadata, error in
                if let error = error {
                    print("Error uploading image: \(error)")
                    return
                }
                
                storageRef.downloadURL { url, error in
                    if let error = error {
                        print("Error getting download URL: \(error)")
                        return
                    }
                    
                    if let imageURL = url {
                        let pictureData: [String: Any] = [
                            "image_url": imageURL.absoluteString,
                            "notes": notes,
                            "timestamp": Timestamp(date: Date())
                        ]
                        
                        let db = Firestore.firestore()
                        db.collection("users").document(userId).collection("pictures").addDocument(data: pictureData) { error in
                            if let error = error {
                                print("Error saving document: \(error)")
                            } else {
                                print("Document successfully saved")
                                self.image = nil
                                self.notes = ""
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
