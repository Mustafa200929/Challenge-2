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
import CoreImage.CIFilterBuiltins

func makeMask(image: UIImage) -> Image {
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
    
    let finalImage = Image(decorative: convertCIImageToCGImage(input: compositeImage), scale: 1)
    return finalImage
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

struct ImageSegmentation: View {
    @State private var finalImage: Image?
    var body: some View {
        ZStack{
            if let finalImage {
                finalImage
                    .resizable()
            }
        }
        .onAppear{
            guard let uiImage = UIImage(named: "Screenshot 2025-08-22 at 7.00.59 PM") else{
                fatalError("Cannot find image")
            }
            let maskedImage = makeMask(image: uiImage)
            finalImage = maskedImage
        }
    }
}

#Preview{
    ImageSegmentation()
}

