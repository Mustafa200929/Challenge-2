//
//  ImageProcessor.swift
//  Challenge 2
//
//  Created by Mustafa Topiwala on 5/9/25.
//
import SwiftUI

class ImageProcessor: ObservableObject {
    @Published var currentSession = ImageSession()
    
    func execute(image: UIImage){
        currentSession.originalImage = image
        segmentImage()
        if currentSession.topImage != nil && currentSession.bottomImage != nil {
            getModelInfo( )
        }else{
            print("Something went wrong")
            return
        }
        getPixelInfo()
        getPoints()
    }
    
    func segmentImage() {
        guard let image = currentSession.originalImage else {return}
        if let (bottom, top) = makeMask(image: image) {
            currentSession.bottomImage = bottom
            currentSession.topImage = top
        }
    }
    
    func getModelInfo(){
        guard let top = currentSession.topImage else {return}
        guard let bottom = currentSession.bottomImage else {return}
        if let (topType, bottomType) = loadModel(topImage: top, bottomImage: bottom) {
            currentSession.topType = topType
            currentSession.bottomType = bottomType
        }
    }
    func getPixelInfo(){
        guard let top = currentSession.topImage else {return}
        guard let bottom = currentSession.bottomImage else {return}
        if let topBrightness = getBrightnessValue(image: top),
           let bottomBrightness = getBrightnessValue(image: bottom ){
            currentSession.topBrightness = topBrightness
            currentSession.bottomBrightness = bottomBrightness
        }
    }
    
    func getPoints(){
        guard let topType = currentSession.topType else {return}
        guard let bottomType = currentSession.bottomType else {return}
        guard let topBrightness = currentSession.topBrightness else {return}
        guard let bottomBrightness = currentSession.bottomBrightness else {return}
        currentSession.points = AllocatePoints(topType: topType, bottomType: bottomType, topBrightness: topBrightness, bottomBrightness: bottomBrightness)
    }
    
    func getChallenges()->(String,String){
        let challenge = Pairings.randomElement()!
        let bottom = challenge[0]
        let top = challenge[1]
        return(bottom,top)
    }
    
    func evaluateChallenge(bottom: String, top: String){
        guard let topType = currentSession.topType else {return}
        guard let bottomType = currentSession.bottomType else {return}
        if topType == top && bottomType == bottom{
            currentSession.challengePassed = true
        }else{
            currentSession.challengePassed = false
        }
    }
    
    func convertToReadableString(bottom: String, top: String)->(String, String){
        var bottomReadable = ""
        var topReadable = ""
        switch bottom{
        case "denim_bottom": bottomReadable = "Denim Bottom"
        case "patterned_bottom": bottomReadable = "Patterned Bottom"
        default: bottomReadable = bottom
        }
        switch top{
        case "denim_top": topReadable = "Denim Top"
        case "patterned_top": topReadable = "Patterned Top"
        default: topReadable = top
        }
        return(bottomReadable, topReadable)
    }
}
