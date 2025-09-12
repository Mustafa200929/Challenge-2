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

extension UIImage {
    var fixedOrientation: UIImage {
        if imageOrientation == .up { return self }
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(origin: .zero, size: size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return normalizedImage ?? self
    }
}

func makeMask(image: UIImage) -> (UIImage,UIImage)? {
    var hipY: CGFloat = 0.5
    guard let ciImage = CIImage(image: image.fixedOrientation) else{return nil}
    let poseHandler = VNImageRequestHandler(ciImage: ciImage)
    let poseRequest = VNDetectHumanBodyPoseRequest()
    do{try poseHandler.perform([poseRequest])}catch{return nil}
    guard let poseResult = poseRequest.results?.first as? VNHumanBodyPoseObservation else {return nil}
    if let leftHip = try? poseResult.recognizedPoint(.leftHip),
       let rightHip = try? poseResult.recognizedPoint(.rightHip){
       hipY = (leftHip.y + rightHip.y) / 2
    }else{return nil}
    let imageHeight = ciImage.extent.height
    let hipPixelY = hipY * imageHeight
    let personRequest = VNGeneratePersonSegmentationRequest()
    personRequest.outputPixelFormat = kCVPixelFormatType_OneComponent8
    personRequest.qualityLevel = .accurate
    let personHandler = VNImageRequestHandler(ciImage: ciImage)
    do{try personHandler.perform([personRequest])}catch{return nil}
    guard let personResult = personRequest.results?.first as? VNPixelBufferObservation else {return nil}
    let maskBuffer = personResult.pixelBuffer
    let maskImage = CIImage(cvPixelBuffer: maskBuffer)
    let compositeImage = applyMask(mainImage: ciImage, maskImage: maskImage)
    let (bottomCroppedImage,topCroppedImage) = cropImage(inputImage: compositeImage, hipPixelY: hipPixelY)
    let bottomCroppedUIImage = UIImage(cgImage: convertCIImageToCGImage(input:bottomCroppedImage))
    let topCroppedUIImage = UIImage(cgImage: convertCIImageToCGImage(input:topCroppedImage))
    return (bottomCroppedUIImage,topCroppedUIImage)
}

func applyMask(mainImage: CIImage, maskImage: CIImage) -> CIImage {
    let scaleX = mainImage.extent.width / maskImage.extent.width
    let scaleY = mainImage.extent.height / maskImage.extent.height
    let scaleTransform = CGAffineTransform(scaleX: scaleX, y: scaleY)
    let scaledMaskImage = maskImage.transformed(by: scaleTransform)
    let compositeImage = mainImage.applyingFilter("CIBlendWithMask", parameters:[kCIInputMaskImageKey: scaledMaskImage])
    return compositeImage
}

func convertCIImageToCGImage(input: CIImage) -> CGImage! {
    let context = CIContext(options: nil)
    return context.createCGImage(input, from: input.extent)
}

func cropImage(inputImage: CIImage, hipPixelY: CGFloat) -> (CIImage, CIImage) {
    let width = inputImage.extent.width
    let height = inputImage.extent.height
    let headHeight = height * 0.2
    let bottomRect = CGRect(x: 0, y: 0, width: width, height: hipPixelY)
    let bottomCropped = inputImage.cropped(to: bottomRect)
    let topRect = CGRect(x: 0, y: hipPixelY, width: width, height: height - hipPixelY - headHeight)
    let topCropped = inputImage.cropped(to: topRect)
    return (bottomCropped, topCropped)
}


