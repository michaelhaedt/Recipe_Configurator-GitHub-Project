//
//  SwiftUIView.swift
//  Recipe_Configurator
//
//  Created by Michael Haedt on 5/6/24.
//

import SwiftUI
import PhotosUI
import FirebaseStorage
import FirebaseFirestore

struct SwiftUIView: View {
    
    @State var recipeUIImage: UIImage?
    @State var photosPickerItem: PhotosPickerItem?
    @State var retrievedImages = [UIImage]()
    
    var body: some View {
        VStack{
            
            PhotosPicker(selection: $photosPickerItem, matching: .images) {
                Text("image")
                Image( uiImage: recipeUIImage ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(.circle)
            }
        }.padding(3)
            .onChange(of: photosPickerItem) { oldValue, newValue in
                Task{
                    if let photosPickerItem,
                       let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                        if let image  = UIImage(data: data) {
                            recipeUIImage = image
                            uploadPhoto()
                            retrievePhotos()
                        }
                    }
                }
            }
    }
    
    
    
    func uploadPhoto() {
        
        guard recipeUIImage != nil else {
            return
            
        }
        let storageRef = Storage.storage().reference()
        
        let imageData = recipeUIImage!.jpegData(compressionQuality: 0.8)
        
        guard imageData != nil else {
            return
        }
        let path = "images/\(UUID().uuidString).jpg"
        let fileRef =  storageRef.child(path)
        
        let uploadTask = fileRef.putData(imageData!, metadata: nil) {
            
            metadata, error in
            
            if error == nil && metadata != nil {
                
                let db = Firestore.firestore()
                db.collection("images").document().setData(["url":path])
            }
        }
    }
    
    func retrievePhotos() {
        
        let db = Firestore.firestore()
        
        db.collection("images").getDocuments { snapshot, error in
            
            if error == nil && snapshot != nil {
                
                
                var paths = [String]()
                
                for doc in snapshot!.documents {
                    
                    paths.append(doc["url"] as! String)
                    
                    
                }
                for path in paths {
                    
                    let storageRef =  Storage.storage().reference()
                    let fileRef = storageRef.child(path)
                    fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                        
                        if error == nil && data != nil {
                            if let image = UIImage(data: data!){
                                
                                DispatchQueue.main.async {
                                    
                                    retrievedImages.append(image)
                                }
                                
                            }
                        }
                        
                    }
                    
                }
                
            }
        }
    }
}
    
