//
//  ContentView.swift
//  Recipe_Configurator
//
//  Created by Michael Haedt on 4/26/24.
//

/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The main content view of the app.
*/

import SwiftUI
import PhotosUI
import FirebaseFirestore
import Firebase

struct Profile: View {
    var body: some View {
        #if os(macOS)
        ProfileForm()
            .labelsHidden()
            .frame(width: 400)
            .padding()
        #else
        NavigationView {
            ProfileForm()
        }
        #endif
    }
}

struct ProfileForm: View {
    @StateObject var viewModel = ProfileModel()
    @State var firstName = ""
    @State var lastName = ""
    @State var aboutMe = ""
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Spacer()
                    EditableCircularProfileImage(viewModel: viewModel)
                   
                    
                    Spacer()
                }
            }
            .listRowBackground(Color.clear)
#if !os(macOS)
            .padding([.top], 10)
#endif
            Section {
                TextField("First Name",
                          text: $firstName,
                          prompt: Text("First Name"))
                TextField("Last Name",
                          text: $lastName,
                          prompt: Text("Last Name"))
            }
            Section {
                TextField("About Me",
                          text: $aboutMe,
                          prompt: Text("About Me"))
                
                Section{
                    Button( "Submit", action : {
                        let profileSubmit = [
                            "First Name":self.firstName,
                            "Last Name":self.lastName,
                            "About Me":self.aboutMe ]
                        
                        let docRef = Firestore.firestore().document("recipes/\(UUID().uuidString)")
                        print("setting data")
                        docRef.setData(profileSubmit){ (error) in
                            if let error = error {
                                print("error = \(error)")
                            } else {
                                print("data uploaded successfully")
                            }
                        }
                    })
                    
                }
            }
            
            .navigationTitle("Account Profile")
        }
        
    }
}
