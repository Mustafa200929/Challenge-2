//
//  ImageSession.swift
//  Challenge 2
//
//  Created by Mustafa Topiwala on 5/9/25.
//
import UIKit
import SwiftUI

struct ImageSession: Identifiable {
    let id = UUID()
    var originalImage: UIImage?
    var topImage: UIImage?
    var bottomImage: UIImage?
    var bottomType: String?
    var topType: String?
    var bottomBrightness: CGFloat?
    var topBrightness: CGFloat?
    var points: Int = 0
    var tagLine: String?
    
}
