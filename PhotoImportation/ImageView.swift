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
    @EnvironmentObject var processor: ImageProcessor
    @EnvironmentObject var pointsProcessor: PointsProcessor
    @State private var resultsViewShown: Bool = false
    var body: some View{
        VStack{
            Text("Ensure your entire outfit is visible in the photo")
                .font(.caption)
                .padding()
            if let selectedImage{
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .padding()
                
                Button{
                    resultsViewShown.toggle()
                    processor.execute(image: selectedImage)
                }label:{
                    Text("Evaluate Image")
                        .frame(width: 130)
                        .padding()
                        .foregroundStyle(Colours.text)
                        .background(Colours.airForceBlue)
                        .clipShape(Capsule())
                }
                .fullScreenCover(isPresented: $resultsViewShown){
                    ResultsViewScan()
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
    }
}

#Preview{
    ImageView(selectedImage: .constant(UIImage(named: "Photo 2")!))
        .environmentObject(ImageProcessor())
}
