//
//  HomeView.swift
//  Challenge 2
//
//  Created by Mustafa Topiwala on 23/8/25.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedImage: UIImage?
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    HStack{
                        Image(systemName: "trophy")
                        Button{
                            
                        }label:{
                            Text("200")
                                .foregroundStyle(Colours.text)
                        }
                    }
                    .padding()
                    .background(Colours.cambridgeBlue2)
                    .clipShape(RoundedRectangle(cornerRadius: .infinity))
                    Spacer()
                    Text("CONFORMIST") //integrate with backend later
                        .padding()
                        .background(Colours.cambridgeBlue2)
                        .clipShape(RoundedRectangle(cornerRadius: .infinity))
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Colours.celadon)
                .padding(.bottom, 20)
                
                Text("Past Outfits")
                TabView {
                    ForEach(2..<8){ index in
                        Image("Photo \(index)")
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 40))
                    }
                }
                .tabViewStyle(.page)
                .frame(height: 400)
                .padding(.bottom, 20)
                
                
                Text("200 credits")
                NavigationLink{
                    //
                }label:{
                    Text("Solve daily quest")
                        .frame(width: 250)
                        .padding()
                        .font(.title2)
                        .bold()
                        .foregroundStyle(Color.black)
                        .background(Colours.airForceBlue)
                        .clipShape(Capsule())
                        .padding(.bottom, 20)
                }
                
                Text("10-100 credits")
                NavigationLink{
                    ImageView(selectedImage: $selectedImage)
                }label:{
                    Text("Scan your outfit")
                        .frame(width: 250)
                        .padding()
                        .font(.title2)
                        .bold()
                        .foregroundStyle(Color.black)
                        .background(Colours.airForceBlue)
                        .clipShape(Capsule())
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Colours.bone)
            .ignoresSafeArea()
        }
    }
}

#Preview{
    HomeView()
}
