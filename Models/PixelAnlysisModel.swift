import UIKit
import SwiftUI

func getBrightnessValue(image: UIImage) -> CGFloat? {
        guard let inputImage = CIImage(image: image) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        let red = CGFloat(bitmap[0]) / 255
        let green = CGFloat(bitmap[1]) / 255
        let blue = CGFloat(bitmap[2]) / 255
        let brightness = 0.2126*red + 0.7152*green + 0.0722*blue
        return brightness
}
