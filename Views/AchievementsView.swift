//
//  Achievements.swift
//  Challenge 2
//
//  Created by Mustafa Topiwala on 10/9/25.
//

import SwiftUI

struct AchievementsView: View {
    let progress1: Double = 1.0
    let progress2: Double = 0.65
    let progress3: Double = 0.3
    let progress4: Double = 0.0
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
                
                Text("1800 points to Conformist")
                    .padding()
                
                Spacer()
                HStack {
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
                                    .trim(from: 0, to: progress1)
                                    .stroke(
                                        Colours.cambridgeBlue2,
                                        style: StrokeStyle(lineWidth: 8, lineCap: .round)
                                    )
                                    .rotationEffect(.degrees(-90))
                                    .frame(width: 120, height: 120)
                                    .animation(.easeOut(duration: 1.0), value: progress1)
                                
                                Text("\(Int(progress1 * 100))%")
                                    .frame(width: 100, height: 100)
                                    .background(Colours.celadon)
                                    .clipShape(Circle())
                                    .foregroundColor(.white)
                                    .bold()
                            }
                            
                            Text("Conformist")
                                .font(.headline)
                        }
                    }
                    if pointsProcessor.noviceRebelUnlocked {
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
                                        .trim(from: 0, to: progress2)
                                        .stroke(
                                            Colours.cambridgeBlue2,
                                            style: StrokeStyle(lineWidth: 8, lineCap: .round)
                                        )
                                        .rotationEffect(.degrees(-90))
                                        .frame(width: 120, height: 120)
                                        .animation(.easeOut(duration: 1.0), value: progress2)
                                    
                                    Text("\(Int(progress2 * 100))%")
                                        .frame(width: 100, height: 100)
                                        .background(Colours.celadon)
                                        .clipShape(Circle())
                                        .foregroundColor(.white)
                                        .bold()
                                }
                                
                                Text("Novice rebel")
                                    .font(.headline)
                            }
                        }
                    }else{
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
                                
                                Text("Novice rebel")
                                    .font(.headline)
                            }
                        }
                    }
                }
                
                Spacer()
                
                HStack {
                    if pointsProcessor.masterOfMismatchUnlocked {
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
                                        .trim(from: 0, to: progress3)
                                        .stroke(
                                            Colours.cambridgeBlue2,
                                            style: StrokeStyle(lineWidth: 8, lineCap: .round)
                                        )
                                        .rotationEffect(.degrees(-90))
                                        .frame(width: 120, height: 120)
                                        .animation(.easeOut(duration: 1.0), value: progress3)
                                    
                                    Text("\(Int(progress3 * 100))%")
                                        .frame(width: 100, height: 100)
                                        .background(Colours.celadon)
                                        .clipShape(Circle())
                                        .foregroundColor(.white)
                                        .bold()
                                }
                                
                                Text("Mischief Master")
                                    .font(.headline)
                            }
                        }
                    }else{
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
                                
                                Text("Mischief Master")
                                    .font(.headline)
                            }
                        }
                    }
                    
                   if pointsProcessor.finalBossUnlocked{
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
                                       .trim(from: 0, to: progress4)
                                       .stroke(
                                           Colours.cambridgeBlue2,
                                           style: StrokeStyle(lineWidth: 8, lineCap: .round)
                                       )
                                       .rotationEffect(.degrees(-90))
                                       .frame(width: 120, height: 120)
                                       .animation(.easeOut(duration: 1.0), value: progress4)
                                   
                                   Text("\(Int(progress4 * 100))%")
                                       .frame(width: 100, height: 100)
                                       .background(Colours.celadon)
                                       .clipShape(Circle())
                                       .foregroundColor(.white)
                                       .bold()
                               }
                               
                               Text("Final fashion boss")
                                   .font(.headline)
                           }
                       }
                   }else{
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
                               
                               Text("Mischief Master")
                                   .font(.headline)
                           }
                       }
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

