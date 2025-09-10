//
//  ImageViewChallenge.swift
//  Challenge 2
//
//  Created by Mustafa Topiwala on 8/9/25.
//

import SwiftUI
import PhotosUI

struct ImageViewChallenge: View{
    @Binding var selectedImage: UIImage?
    @State private var selectedItem: PhotosPickerItem?
    @State private var cameraViewShown: Bool = false
    @State private var finalBottomImage: Image?
    @State private var finalTopImage: Image?
    @StateObject var processor = ImageProcessor()
    @State private var topRaw: String = ""
    @State private var bottomRaw: String = ""
    @State private var bottomReadable: String = ""
    @State private var topReadable: String = ""
    
    var body: some View{
        VStack{
            HStack{
                Image(systemName: "target")
                Text("Wear a \(bottomReadable) with a \(topReadable)")
            }
            if let selectedImage{
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .padding()
                
                NavigationLink{
                    ResultsViewChallenge(topReadable: $topReadable, bottomReadable: $bottomReadable)
                        .environmentObject(processor)
                        .onAppear{
                            processor.execute(image: selectedImage)
                            processor.evaluateChallenge(bottom: bottomRaw, top: topRaw)
                        }
                }label:{
                    Text("Evaluate Image")
                        .frame(width: 130)
                        .padding()
                        .foregroundStyle(Colours.text)
                        .background(Colours.airForceBlue)
                        .clipShape(Capsule())
                }
            }else{
                Text("No image selected")
                    .foregroundStyle(.gray)
                    .padding()
            }
            Button{
                cameraViewShown.toggle()
            }label:{
                Text("Take photo")
                    .frame(width: 130)
                    .padding()
                    .foregroundStyle(Colours.text)
                    .background(Colours.cambridgeBlue1)
                    .clipShape(Capsule())
            }
            .sheet(isPresented: $cameraViewShown){
                CameraView(image: $selectedImage)
            }
            PhotosPicker(selection: $selectedItem, matching: .images){
                Text("Pick Image")
                    .frame(width: 130)
                    .padding()
                    .foregroundStyle(Colours.text)
                    .background(Colours.cambridgeBlue1)
                    .clipShape(Capsule())
                    .onChange(of: selectedItem){ item in
                        if let item = item{
                            Task{
                                if let data = try? await item.loadTransferable(type: Data.self){
                                    let image = UIImage(data: data)
                                    selectedImage = image
                                }
                            }
                        }
                    }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Colours.bone)
        .onAppear{
            let (top, bottom) = processor.getChallenges()
            topRaw = top
            bottomRaw = bottom
            let (bottomInterReadable, topInterReadable) = processor.convertToReadableString(bottom: bottomRaw, top: topRaw)
            bottomReadable = bottomInterReadable
            topReadable = topInterReadable
        }
    }
}

#Preview{
    ImageViewChallenge(selectedImage: .constant(UIImage(named: "Photo 2")!))
}
