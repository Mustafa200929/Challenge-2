//
//  PointsProcessor.swift
//  Challenge 2
//
//  Created by Mustafa Topiwala on 10/9/25.
//

import SwiftUI

class PointsProcessor: ObservableObject {
    @AppStorage("userPoints") var points: Int = 0
    @AppStorage("conformistUnlocked") var conformistUnlocked: Bool = true
    @AppStorage("noviceRebelUnlocked") var noviceRebelUnlocked: Bool = false
    @AppStorage("masterOfMismatchUnlocked") var masterOfMismatchUnlocked: Bool = false
    @AppStorage("finalBossUnlocked") var finalBossUnlocked: Bool = false
    
    
    func addPoints(value: Int) {
        points += value
        checkAchievements()
    }
    
    private func checkAchievements() {
        if points >= 200 { noviceRebelUnlocked = true }
        if points >= 400 { masterOfMismatchUnlocked = true }
        if points >= 800 { finalBossUnlocked = true }
    }
}
