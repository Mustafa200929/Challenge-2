//
//  AchievmentsModel.swift
//  Challenge 2
//
//  Created by Mustafa Topiwala on 10/9/25.
//
import SwiftUI

struct Achievements{
    let Conformist = 200
    let Novice_rebel = 400
    let Mismatch_master = 800
    let Final_fashion_boss = 1600
}

func achievementCard(pointsInt: Int, title: String, thresholdInt: Int) -> some View {
    ZStack {
        Rectangle()
            .fill(.gray)
            .frame(width: 160, height: 180)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .opacity(0.3)
            .padding()
        
        VStack {
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 8)
                    .frame(width: 120, height: 120)
                
                Circle()
                    .trim(from: 0, to: Double(pointsInt)/Double(thresholdInt))
                    .stroke(
                        Colours.cambridgeBlue2,
                        style: StrokeStyle(lineWidth: 8, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                    .frame(width: 120, height: 120)
                    .animation(.easeOut(duration: 1.0), value: Double(pointsInt)/Double(thresholdInt))
                
                Text("\(Int(Double(pointsInt)/Double(thresholdInt) * 100))%")
                    .frame(width: 100, height: 100)
                    .background(Colours.celadon)
                    .clipShape(Circle())
                    .foregroundColor(.white)
                    .bold()
            }
            
            Text(title)
                .font(.headline)
        }
    }
}

func achievementCardLocked(title: String) -> some View {
    ZStack {
        Rectangle()
            .fill(.gray)
            .frame(width: 160, height: 180)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .opacity(0.3)
            .padding()
        
        VStack {
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 8)
                    .frame(width: 120, height: 120)
                
                Image(systemName: "lock")
                    .frame(width: 100, height: 100)
                    .background(Colours.celadon)
                    .clipShape(Circle())
                    .foregroundColor(.white)
                    .bold()
            }
            
            Text(title)
                .font(.headline)
        }
    }
}

func achievementCardExcess(title: String) -> some View {
    ZStack {
        Rectangle()
            .fill(.gray)
            .frame(width: 160, height: 180)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .opacity(0.3)
            .padding()
        
        VStack {
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 8)
                    .frame(width: 120, height: 120)
                
                Circle()
                    .trim(from: 0, to: 1)
                    .stroke(
                        Colours.cambridgeBlue2,
                        style: StrokeStyle(lineWidth: 8, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                    .frame(width: 120, height: 120)
                    .animation(.easeOut(duration: 1.0), value: 1)
                
                Text("100%")
                    .frame(width: 100, height: 100)
                    .background(Colours.celadon)
                    .clipShape(Circle())
                    .foregroundColor(.white)
                    .bold()
            }
            
            Text(title)
                .font(.headline)
        }
    }
}

