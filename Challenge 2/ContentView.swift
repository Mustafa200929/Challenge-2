//
//  ContentView.swift
//  Challenge 2
//
//  Created by Mustafa Topiwala on 23/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedImage: UIImage?
    var body: some View {
        NavigationStack{
              ImageView(selectedImage: $selectedImage)
        }
    }
}


#Preview {
    ContentView()
}
