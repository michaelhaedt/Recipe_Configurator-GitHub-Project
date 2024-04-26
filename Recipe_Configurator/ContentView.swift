//
//  ContentView.swift
//  Recipe_Configurator
//
//  Created by Michael Haedt on 4/26/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            NavigationLink("hello world", destination: Recipes())
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
