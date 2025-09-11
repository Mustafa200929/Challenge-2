//
//  Challenge_2App.swift
//  Challenge 2
//
//  Created by Mustafa Topiwala on 23/8/25.
//

import SwiftUI

@main
struct Challenge_2App: App {
    @StateObject var pointsProcessor = PointsProcessor()
    @StateObject var processor = ImageProcessor()
    @StateObject var storageProcessor = StorageProcessor()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(pointsProcessor)
                .environmentObject(processor)
                .environmentObject(storageProcessor)
            
        }
    }
}
