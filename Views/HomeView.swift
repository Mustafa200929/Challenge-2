//
//  HomeView.swift
//  Challenge 2
//
//  Created by Mustafa Topiwala on 23/8/25.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedImage: UIImage?
    @EnvironmentObject var pointsProcessor: PointsProcessor
    @EnvironmentObject var storageProcessor: StorageProcessor
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    NavigationLink{
                        AchievementsView()
                    }label:{
                        HStack{
                            Image(systemName: "trophy")
                                .foregroundStyle(Colours.text)
                            Text("\(pointsProcessor.points)")
                                .foregroundStyle(Colours.text)
                                .font(.caption.weight(.semibold))
                        }
                        .padding()
                        .background(Colours.cambridgeBlue2)
                        .clipShape(RoundedRectangle(cornerRadius: .infinity))
                    }
                    .buttonStyle(.plain)
                    Spacer()
                    let(achievement) = pointsProcessor.checkUnlocked()
                    if achievement == "" {
                        Text("Play to unlock your first achievement!")
                            .padding()
                            .background(Colours.cambridgeBlue1)
                            .clipShape(RoundedRectangle(cornerRadius: .infinity))
                            .font(.callout.weight(.medium))
                    }else{
                        Text(achievement)
                            .padding()
                            .background(Colours.cambridgeBlue1)
                            .clipShape(RoundedRectangle(cornerRadius: .infinity))
                            .font(.callout.weight(.medium))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Colours.celadon.ignoresSafeArea(edges: .top))
                .padding(.bottom, 20)
                
                Text("Past Outfits")
                    .font(.title3.weight(.semibold))
                if storageProcessor.images == []{
                    Text("No outfits saved yet!")
                }
                TabView {
                    ForEach(storageProcessor.images.indices, id: \.self){ index in
                        Image(uiImage: storageProcessor.images[index])
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .shadow(radius: 4)
                            .padding()
                    }
                }
                .tabViewStyle(.page)
                .frame(height: 400)
                .padding(.bottom, 20)
                
                
                Text("100 credits")
                    .font(.footnote.weight(.regular))
                NavigationLink{
                    ImageViewChallenge(selectedImage: $selectedImage)
                }label:{
                    Text("Attempt quest")
                        .frame(width: 250)
                        .padding()
                        .font(.headline.weight(.semibold))
                        .bold()
                        .foregroundStyle(Color.black)
                        .background(Colours.airForceBlue)
                        .clipShape(Capsule())
                        .padding(.bottom, 20)
                }
                .buttonStyle(.plain)
                
                Text("10-50 credits")
                    .font(.footnote.weight(.regular))
                NavigationLink{
                    ImageView(selectedImage: $selectedImage)
                }label:{
                    Text("Scan your outfit")
                        .frame(width: 250)
                        .padding()
                        .font(.headline.weight(.semibold))
                        .bold()
                        .foregroundStyle(Color.black)
                        .background(Colours.airForceBlue)
                        .clipShape(Capsule())
                }
                .buttonStyle(.plain)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Colours.bone)
            .ignoresSafeArea()
        }
    }
}

#Preview{
    HomeView()
        .environmentObject(PointsProcessor())
        .environmentObject(ImageProcessor())
        .environmentObject(StorageProcessor())
}
