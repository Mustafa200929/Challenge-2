//
//  Challenge_2App.swift
//  Challenge 2
//
//  Created by Mustafa Topiwala on 23/8/25.
//

import SwiftUI

@main
struct Challenge_2App: App {

    var body: some Scene {
        @StateObject var pointsProcessor = PointsProcessor()
        WindowGroup {
            ContentView()
                .environmentObject(pointsProcessor)
        }
    }
}
