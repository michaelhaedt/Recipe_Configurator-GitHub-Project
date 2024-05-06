//
//  ContentView.swift
//  Recipe_Configurator
//
//  Created by Michael Haedt on 4/30/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            //NavigationLink("Photpicker", destination: Photopicker())
            NavigationLink("Recipe", destination: Recipes())
            NavigationLink("Create Profile", destination: Profile())
            NavigationLink("Create UIImage", destination: SwiftUIView())
        }
    }
}

#Preview {
    ContentView()
}
