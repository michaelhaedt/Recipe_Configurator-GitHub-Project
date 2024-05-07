/*import PhotosUI
import SwiftUI
import FirebaseStorage

struct Photopicker: View {
    @State var recipeItem: PhotosPickerItem?
    @State var recipeImage: Image?
    //@State private var isPickerShowing = false
    
    var body: some View {
        VStack {
            
            PhotosPicker("Select Recipe Photo", selection: $recipeItem, matching: .images)
            
            recipeImage?
            let uiImage:UIImage = recipeImage.asUIImage()
                .resizable()
                .frame(width: 300, height: 300)
        }
        .onChange(of: recipeItem) {
            Task {
                if let loaded = try? await recipeItem?.loadTransferable(type: Image.self) {
                    recipeImage = loaded
                } else {
                    print("Failed")
                }
            }
            
        }
        
        
    }
    func uploadPhoto() {
        
        guard recipeImage != nil else {
            return
            
        }
        let storageRef = Storage.storage().reference()
        
        let imageData = recipeImage!.pngData(withActions: <#T##UIGraphicsImageRenderer.DrawingActions#>)
        
        guard imageData != nil else {
            return
        }
        
        let fileRef =  storageRef.child("images/\(UUID().uuidString).jpg")
        
        let uploadTask = fileRef.putData(imageData!, metadata: nil) {
            metadata, error in
            
            if error == nil && metadata != nil {
            }
        }
    }
    
}
*/
