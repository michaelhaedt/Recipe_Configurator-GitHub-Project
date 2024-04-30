//
//  Recipes.swift
//  Recipe_Configurator
//
//  Created by Michael Haedt on 4/26/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore




struct Recipes: View {
    
    
    @State var recipeName = ""
    @State var ingredientName = ""
    @StateObject var viewModel = ProfileModel()
    
    var body: some View {
        
        TextField("Add a Recipe Name", text: $recipeName)
        TextField("Add an Ingredient Name", text: $ingredientName)
        
        ScrollView{
            Text("This will be a scroll view")
            
        }.frame(width: UIScreen.main.bounds.size.width)
            .background(Color.red)
        
        Button( action : {
            let recipeConfigurator = [
                "recipe name":self.recipeName,
                "ingredient name":self.ingredientName
            ]
            
            let docRef = Firestore.firestore().document("recipes/\(UUID().uuidString)")
            print("setting data")
            docRef.setData(recipeConfigurator){ (error) in
                if let error = error {
                    print("error = \(error)")
                } else {
                    print("data uploaded successfully")
                }
            }
        }){
            Text("Add Recipe")
        }
    }
}


        
        
