//
//  Achievements.swift
//  Challenge 2
//
//  Created by Mustafa Topiwala on 10/9/25.
//

import SwiftUI

struct AchievementsView: View {

    @EnvironmentObject var pointsProcessor: PointsProcessor
    var body: some View {
        VStack {
            Spacer()
            VStack {
                HStack {
                    Image(systemName: "trophy")
                        .resizable()
                        .frame(width: 50, height: 50)
                    Text("\(pointsProcessor.points)")
                        .font(.title)
                        .padding()
                }
                let (tagline, points) = pointsProcessor.getValueToAchievement()
                if points == 0{
                    Text("You have beaten the game")
                        .padding()
                }else{
                    Text("Points to achieve \(tagline): \(points)")
                        .padding()
                }
                Spacer()
                HStack {
                    if pointsProcessor.points > pointsProcessor.achievements.Conformist {
                        achievementCardExcess(title: "Conformist")
                    }
                    else{
                        achievementCard(pointsInt: pointsProcessor.points, title: "Conformist", thresholdInt: pointsProcessor.achievements.Conformist)
                    }
                    if pointsProcessor.noviceRebelUnlocked {
                        if pointsProcessor.points > pointsProcessor.achievements.Novice_rebel {
                            achievementCardExcess(title: "Novice rebel")
                        }
                        else{
                            achievementCard(pointsInt: pointsProcessor.points, title: "Novice rebel", thresholdInt: pointsProcessor.achievements.Novice_rebel)
                        }
                    }else{achievementCardLocked(title: "Novice rebel")}
                }
                Spacer()
                HStack {
                    if pointsProcessor.masterOfMismatchUnlocked {
                        if pointsProcessor.points > pointsProcessor.achievements.Mismatch_master {
                            achievementCardExcess(title: "Mismatch master")
                        }else{
                            achievementCard(pointsInt: pointsProcessor.points, title: "Mismatch master", thresholdInt: pointsProcessor.achievements.Mismatch_master)
                        }
                    }else{
                        achievementCardLocked(title: "Mismatch master")
                    }
                    if pointsProcessor.finalBossUnlocked{
                        if pointsProcessor.points>pointsProcessor.achievements.Final_fashion_boss{
                            achievementCardExcess(title: "Final fashion boss")
                        }else{
                            achievementCard(pointsInt: pointsProcessor.points, title: "Final fashion boss", thresholdInt: pointsProcessor.achievements.Final_fashion_boss)
                        }
                    }else{
                        achievementCardLocked(title: "Final fashion boss")
                    }
                }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Colours.bone)
    }
}

#Preview {
    AchievementsView()
        .environmentObject(PointsProcessor())
}

