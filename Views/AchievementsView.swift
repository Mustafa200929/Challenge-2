//
//  Achievements.swift
//  Challenge 2
//
//  Created by Mustafa Topiwala on 10/9/25.
//

import SwiftUI

struct AchievementsView: View {
    @EnvironmentObject var pointsManager: PointsPro
    private let goal: Int = 5000
    
    var progress: Double {
        Double(pointsManager.points) / Double(goal)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Title + Back
            HStack {
                Button(action: {
                    // back action here
                }) {
                    Label("Back", systemImage: "chevron.left")
                        .foregroundColor(.blue)
                }
                Spacer()
            }
            .padding(.leading)
            
            Text("Achievements")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.black)
                .padding(.bottom, 10)
            
            // Points summary
            VStack(spacing: 6) {
                HStack {
                    Image(systemName: "trophy.fill")
                        .foregroundColor(.yellow)
                    Text("\(pointsManager.points)/\(goal)")
                        .font(.headline)
                }
                Text("\(goal - pointsManager.points) pts to next level")
                    .font(.caption)
                    .foregroundColor(.black.opacity(0.7))
            }
            
            // Achievements Grid
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 24) {
                
                AchievementCard(
                    progress: min(1.0, progress), // always between 0–1
                    title: "Conformist",
                    locked: progress < 0.2 // unlock at 20%+
                )
                
                AchievementCard(
                    progress: min(1.0, progress - 0.2), // progress after 20%
                    title: "Novice Rebel",
                    locked: progress < 0.4
                )
                
                AchievementCard(
                    progress: min(1.0, progress - 0.4),
                    title: "Master of Mismatch",
                    locked: progress < 0.7
                )
                
                AchievementCard(
                    progress: min(1.0, progress - 0.7),
                    title: "Final Fashion Boss",
                    locked: progress < 1.0
                )
            }
            .padding(.top, 10)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Colours.bone)
    }
}

struct AchievementCard: View {
    var progress: Double  // 0.0 to 1.0
    var title: String
    var locked: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(Color.teal.opacity(0.3), lineWidth: 8)
                    .frame(width: 70, height: 70)
                
                Circle()
                    .trim(from: 0, to: locked ? 0 : progress)
                    .stroke(Color.teal, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .frame(width: 70, height: 70)
                    .animation(.easeOut(duration: 1.0), value: progress)
                
                if locked {
                    Image(systemName: "lock.fill")
                        .foregroundColor(.gray)
                        .font(.title2)
                } else {
                    Text("\(Int(progress * 100))%")
                        .foregroundColor(.black)
                        .font(.footnote)
                        .bold()
                }
            }
            Text(title)
                .font(.footnote)
                .multilineTextAlignment(.center)
                .padding(.top, 6)
        }
        .frame(width: 120, height: 120)
        .background(Color.white.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 4, y: 2)
    }
}

#Preview {
    let mock = PointsProcessor()
    mock.points = 3200
    return AchievementsView()
        .environmentObject(mock)
}

