//
//  PointsAllocationModel.swift
//  Challenge 2
//
//  Created by Mustafa Topiwala on 5/9/25.
//

import SwiftUI

func AllocatePoints(topType: String, bottomType: String, topBrightness: CGFloat, bottomBrightness: CGFloat) -> Int {
    var points = 0
    if topType == "denim_top" || topType == "patterned_top"{
        points += 1
    }
    if bottomType == "patterned_bottom" || bottomType == "denim_bottom"{
        points += 1
    }
    if (topType == "denim_top" && bottomType == "denim_bottom" ) ||
        (topType == "denim_top" && bottomType == "patterned_top") ||
        (topType == "patterned_top" && bottomType == "denim_bottom") ||
        (topType == "patterned_top" && bottomType == "patterned_bottom"){
        points += 1
    }
    if topBrightness > 0.2{
        points += 1
    }
    if bottomBrightness > 0.2{
        points += 1
    }
    if points == 0{
        points += 1
    }
    return points
}
