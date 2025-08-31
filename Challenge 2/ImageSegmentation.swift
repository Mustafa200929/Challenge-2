//
//  ImageSegmentation.swift
//  Challenge 2
//
//  Created by Mustafa Topiwala on 29/8/25.
//
import SwiftUI
import Vision
import UIKit
import CoreImage


func makeMask(image: UIImage) -> (Image,Image) {
    guard let ciImage = CIImage(image: image) else {
        fatalError("Could not get cgImage from UIImage")
    }
    let request = VNGeneratePersonSegmentationRequest()
    request.outputPixelFormat = kCVPixelFormatType_OneComponent8
    request.qualityLevel = .accurate
    
    let handler = VNImageRequestHandler(ciImage: ciImage)
    
    do{
        try handler.perform([request])
    }catch{
        fatalError("Could not perform request")
    }
    
    guard let result = request.results?.first as? VNPixelBufferObservation else {
        fatalError("cannot get result")
    }
    
    let maskBuffer = result.pixelBuffer
    let maskImage = CIImage(cvPixelBuffer: maskBuffer)
    let compositeImage = applyMask(mainImage: ciImage, maskImage: maskImage)
    let (bottomCroppedImage,topCroppedImage) = cropImage(inputImage: compositeImage)
    let finalBottomImage = Image(decorative: convertCIImageToCGImage(input: bottomCroppedImage), scale: 1)
    let finalTopImage = Image(decorative: convertCIImageToCGImage(input: topCroppedImage), scale: 1)
    return (finalBottomImage, finalTopImage)
}

func convertCIImageToCGImage(input: CIImage) -> CGImage! {
    let context = CIContext(options: nil)
    return context.createCGImage(input, from: input.extent)
}

func applyMask(mainImage: CIImage, maskImage: CIImage) -> CIImage {
    let scaleX = mainImage.extent.width / maskImage.extent.width
    let scaleY = mainImage.extent.height / maskImage.extent.height
    let scaleTransform = CGAffineTransform(scaleX: scaleX, y: scaleY)
    let scaledMaskImage = maskImage.transformed(by: scaleTransform)
    let compositeImage = mainImage.applyingFilter("CIBlendWithMask", parameters:[kCIInputMaskImageKey: scaledMaskImage])
    return compositeImage
}

func cropImage(inputImage: CIImage) -> (CIImage, CIImage) {
    let width = inputImage.extent.width
    let height = inputImage.extent.height
    let bottomCropRect = CGRect(x: 0, y: 0, width: width, height: height/2)
    let topCropRect = CGRect(x:0, y:height/2, width:width, height:height)
    let bottomCroppedImage = inputImage.cropped(to: bottomCropRect)
    let topCroppedImage = inputImage.cropped(to: topCropRect)
    return (bottomCroppedImage, topCroppedImage)
}

struct ImageSegmentation: View {
    @State private var finalBottomImage: Image?
    @State private var finalTopImage: Image?
    var body: some View {
        VStack{
          finalTopImage
          finalBottomImage
        }
        .onAppear{
            guard let uiImage = UIImage(named: "Screenshot 2025-08-22 at 7.00.59 PM") else{
                fatalError("Cannot find image")
            }
            let (bottomImage, topImage) = makeMask(image: uiImage)
            finalBottomImage = bottomImage
            finalTopImage = topImage
        }
    }
}

#Preview{
    ImageSegmentation()
}

