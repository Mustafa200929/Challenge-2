//
//  HomeView.swift
//  Challenge 2
//
//  Created by Mustafa Topiwala on 23/8/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack{
            HStack{
                HStack{
                    Image(systemName: "trophy")
                    Button{}label:{
                        Text("200")
                    }//integrate with backend later
                }
                .padding()
                .background(Color.yellow)
                .clipShape(RoundedRectangle(cornerRadius: .infinity))
                Spacer()
                Text("You are a CONFORMIST") //integrate with backend later
                    .padding()
                    .background(Color.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: .infinity))
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.teal)
            .padding(.bottom, 20)
            
            Text("Past Outfits")
            TabView {
                ForEach(1..<4){ index in
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
            Button{
                //fill later
            }label:{
                Text("Solve daily quest")
                    .frame(width: 250)
                    .padding()
                    .font(.title)
                    .foregroundStyle(Color.black)
                    .background(Color.teal)
                    .clipShape(Capsule())
                    .padding(.bottom, 20)
            }
            
            Text("10-100 credits")
            Button{
                //fill later
            }label:{
                Text("Scan your outfit")
                    .frame(width: 250)
                    .padding()
                    .font(.title)
                    .foregroundStyle(Color.black)
                    .background(Color.teal)
                    .clipShape(Capsule())
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.pink)
        .ignoresSafeArea()
    }
}


#Preview{
    HomeView()
}
