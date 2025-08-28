//
//  ImageView.swift
//  Challenge 2
//
//  Created by Mustafa Topiwala on 27/8/25.
//
import SwiftUI
import PhotosUI

struct ImageView: View{
    @State private var selectedImage: UIImage?
    @State private var selectedItem: PhotosPickerItem?
    @State private var cameraViewShown: Bool = false
    var body: some View{
        if let selectedImage = selectedImage{
            Image(uiImage: selectedImage)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .padding()
            
            
            //add modifiers later
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
            //CameraView()
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

#Preview{
    ImageView()
}
