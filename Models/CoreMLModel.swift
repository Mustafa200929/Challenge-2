//
//  CoreML.swift
//  Challenge 2
//
//  Created by Mustafa Topiwala on 4/9/25.
//

import CoreML
import SwiftUI
import UIKit
import CoreVideo
import CoreGraphics

extension UIImage {
    func toCVPixelBuffer() -> CVPixelBuffer? {
        let width = Int(self.size.width)
        let height = Int(self.size.height)
        let pixelFormat = kCVPixelFormatType_32BGRA
        var pixelBuffer: CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault,
                                         width,
                                         height,
                                         pixelFormat,
                                         nil,
                                         &pixelBuffer)
        guard status == kCVReturnSuccess, let unwrappedPixelBuffer = pixelBuffer else {
            return nil
        }
        CVPixelBufferLockBaseAddress(unwrappedPixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
        let bufferAddress = CVPixelBufferGetBaseAddress(unwrappedPixelBuffer)
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let bytesPerRow = CVPixelBufferGetBytesPerRow(unwrappedPixelBuffer)
        guard let context = CGContext(data: bufferAddress,
                                      width: width,
                                      height: height,
                                      bitsPerComponent: 8,
                                      bytesPerRow: bytesPerRow,
                                      space: rgbColorSpace,
                                      bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue) else {
            CVPixelBufferUnlockBaseAddress(unwrappedPixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
            return nil
        }
        UIGraphicsPushContext(context)
        self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(unwrappedPixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
        return unwrappedPixelBuffer
    }
}

func loadModel(topImage: UIImage, bottomImage: UIImage) -> (String, String)? {
    guard let topPixelBuffer = topImage.toCVPixelBuffer(),
          let bottomPixelBuffer = bottomImage.toCVPixelBuffer() else { return nil }
    do{
        let topModel = try TopClassifier()
        let topPrediction = try topModel.prediction(image: topPixelBuffer)
        let top = topPrediction.target
        
        let bottomModel = try BottomClassifier()
        let bottomPrediction = try bottomModel.prediction(image: bottomPixelBuffer)
        let bottom = bottomPrediction.target
        
        return(top, bottom)
    }catch{
        return nil
    }
}



