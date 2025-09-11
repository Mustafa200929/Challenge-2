//
//  ContentView.swift
//  Challenge 2
//
//  Created by Mustafa Topiwala on 23/8/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
              HomeView()
        }
    }
}


#Preview {
    ContentView()
        .environmentObject(PointsProcessor())
}
