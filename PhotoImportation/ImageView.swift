//
//  ImageView.swift
//  Challenge 2
//
//  Created by Mustafa Topiwala on 27/8/25.
//
import SwiftUI
import PhotosUI

struct ImageView: View{
    @Binding var selectedImage: UIImage?
    @State private var selectedItem: PhotosPickerItem?
    @State private var cameraViewShown: Bool = false
    @State private var finalBottomImage: Image?
    @State private var finalTopImage: Image?
    @StateObject var processor = ImageProcessor()
    var body: some View{
        if let selectedImage{
            /*Image(uiImage: selectedImage)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .padding()*/
            if let finalTopImage{
                finalTopImage
                    .resizable()
                    .scaledToFit()
                    .padding()
            }
            if let finalBottomImage{
                finalBottomImage
                    .resizable()
                    .scaledToFit()
                    .padding()
            }
                
            Button{
                processor.execute(image: selectedImage)
                let points = processor.currentSession.points
                guard let topType = processor.currentSession.topType,
                      let bottomType = processor.currentSession.bottomType,
                      let bottomBrightness = processor.currentSession.bottomBrightness,
                      let topBrightness = processor.currentSession.topBrightness
                else{
                    return()
                }
                if let bottomImage = processor.currentSession.bottomImage,
                   let topImage = processor.currentSession.topImage{
                    finalTopImage = Image(uiImage: topImage)
                    finalBottomImage = Image(uiImage: bottomImage)
                }
                print("Points: \(points)/5, topType: \(topType), bottomType: \(bottomType), bottomBrightness: \(bottomBrightness), topBrightness: \(topBrightness)")
            }label:{
                Text("Evaluate Image")
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
                .padding()
        }
        .sheet(isPresented: $cameraViewShown){
            CameraView(image: $selectedImage)
        }
        PhotosPicker(selection: $selectedItem, matching: .images){
            Text("Pick Image")
                .padding()
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
}
