//
//  ResultsView.swift
//  Challenge 2
//
//  Created by Mustafa Topiwala on 8/9/25.
//
import SwiftUI

struct ResultsViewScan: View {
    @EnvironmentObject var processor: ImageProcessor
    @EnvironmentObject var pointsProcessor: PointsProcessor
    @EnvironmentObject var storageProcessor: StorageProcessor
    @Environment(\.dismiss) private var dismiss
    @State private var pointsNotAdded = true
    @State private var showHome: Bool = false
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
                    Text("Score: \(processor.currentSession.points)/5\nYou have earned \(processor.currentSession.points*10) points!")
                        .padding()
                        .foregroundStyle(Colours.text)
                        .background(Colours.celadon)
                        .opacity(0.85)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                        .onAppear{
                            if pointsNotAdded{
                                print(processor.currentSession.points)
                                print(processor.currentSession.points*10)
                                pointsProcessor.addPoints(value: processor.currentSession.points*10)
                                pointsNotAdded = false
                            }
                        }

                    if let message = Messages[processor.currentSession.points]{
                        Text(message)
                            .padding()
                            .foregroundStyle(Colours.text)
                            .background(Colours.cambridgeBlue2)
                            .opacity(0.85)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .multilineTextAlignment(.center)
                            .frame(width:300)
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
    mockProcessor.currentSession.topType = "T-shirt"
    mockProcessor.currentSession.bottomType = "Jeans"
    mockProcessor.currentSession.points = 3
    
   return ResultsViewScan()
        .environmentObject(mockProcessor)
        .environmentObject(PointsProcessor())
        .environmentObject(StorageProcessor())
}


