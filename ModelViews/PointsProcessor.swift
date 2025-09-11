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
    @Published var achievements = Achievements()
    
    
    func addPoints(value: Int) {
        points += value
        checkAchievements()
    }
    
    private func checkAchievements() {
        if points >= achievements.Conformist{ noviceRebelUnlocked = true }
        if points >= achievements.Novice_rebel { masterOfMismatchUnlocked = true }
        if points >= achievements.Mismatch_master { finalBossUnlocked = true }
    }
    func getValueToAchievement()->(String,Int){
        if points < achievements.Conformist {
            return ("Confromist", achievements.Conformist-points)
        }
        if points<achievements.Novice_rebel{
            return ("Novice rebel", achievements.Novice_rebel-points)
        }
        if points<achievements.Mismatch_master{
            return ("Mismatch master",achievements.Mismatch_master-points)
        }
        if points<achievements.Final_fashion_boss{
            return ("Final fashion boss",achievements.Final_fashion_boss-points)
        }
        else{
            return ("",0)
        }
    }
    
    func checkUnlocked() -> String {
        if points>achievements.Final_fashion_boss {
            return "Final fashion boss"
        }
        if points>achievements.Mismatch_master {
            return "Mismatch master"
        }
        if points>achievements.Novice_rebel {
            return "Novice rebel"
        }
        if points>achievements.Conformist{
            return "Conformist"
        }
        else{
            return ""
        }
        
    }

}
