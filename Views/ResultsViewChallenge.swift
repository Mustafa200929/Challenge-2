//
//  ResultsView.swift
//  Challenge 2
//
//  Created by Mustafa Topiwala on 8/9/25.
//
import SwiftUI

struct ResultsViewChallenge: View {
    @EnvironmentObject var processor: ImageProcessor
    @EnvironmentObject var pointsProcessor: PointsProcessor
    @EnvironmentObject var storageProcessor: StorageProcessor
    @Binding var topReadable: String
    @Binding var bottomReadable: String
    @State private var showHome = false
    var body: some View {
        VStack{
            HStack{
                Button{
                    showHome.toggle()
                }label:{
                    Image(systemName: "house")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.leading,30)
                        .foregroundStyle(Colours.text)
                    Spacer()
                }
                .buttonStyle(.plain)
                .fullScreenCover(isPresented: $showHome) {
                    HomeView()
                }
                Button{
                    storageProcessor.images.insert(processor.currentSession.originalImage!, at:0)
                    showHome.toggle()
                }label:{
                    Text("Save Outfit?")
                        .padding()
                        .background(Colours.airForceBlue)
                        .clipShape(Capsule())
                        .padding(.trailing)
                        .foregroundStyle(Colours.text)
                }
                .buttonStyle(.plain)
                .fullScreenCover(isPresented: $showHome) {
                    HomeView()
                }

            }
            ZStack{
                    if let originalImage = processor.currentSession.originalImage{
                        Image(uiImage: originalImage)
                            .resizable()
                            .scaledToFit( )
                            .clipShape(RoundedRectangle(cornerRadius: 40))
                            .padding()
                    }else{
                        Text("Sorry! Processing failed. Please try again.")
                    }
                VStack{
                    if processor.currentSession.challengePassed == true{
                        Text("Passed✅\nYou have earned 100 points!")
                            .padding()
                            .foregroundStyle(Colours.text)
                            .background(Colours.celadon)
                            .opacity(0.85)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .multilineTextAlignment(.center)
                            .frame(width: 300)
                            .onAppear{
                                    pointsProcessor.addPoints(value: 100)
                            }
                    }else{
                        Text("Failed❌\nYou did not earn any points this time.")
                            .padding()
                            .foregroundStyle(Colours.text)
                            .background(Colours.celadon)
                            .opacity(0.85)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .multilineTextAlignment(.center)
                            .frame(width: 300)
                        Text("Erm... Where's the \(bottomReadable) the with \(topReadable)??")
                            .padding()
                            .foregroundStyle(Colours.text)
                            .background(Colours.cambridgeBlue2)
                            .opacity(0.85)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .multilineTextAlignment(.center)
                            .frame(width: 300)
                            .font(.headline)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Colours.bone)
    }
}



#Preview {
    let mockProcessor = ImageProcessor()
    mockProcessor.currentSession.originalImage = UIImage(named: "Photo 5")
    mockProcessor.currentSession.topType = "denim_top"
    mockProcessor.currentSession.bottomType = "denim_bottom"
    mockProcessor.currentSession.challengePassed = false
    mockProcessor.currentSession.points = 3

    return ResultsViewChallenge(
        topReadable: .constant("Denim Top"),
        bottomReadable: .constant("Denim Bottom")
    )
    .environmentObject(mockProcessor)
    .environmentObject(PointsProcessor())
    .environmentObject(StorageProcessor())
}


