//
//  Animation.swift
//  Scope
//
//  Created by Fabian Canas on 12/14/15.
//  Copyright © 2015 Fabián Cañas. All rights reserved.
//

import Foundation
import CoreGraphics

@objc public protocol Animation {
    var name :String { get }
    var frameCount :Int { get }
    var frameDuration :Float { get }
    var animationSize :CGSize { get }
    
    func renderInContext(_ context: CGContext)
    func increment()
}

public extension Animation {
    public func clear(_ context: CGContext, color: NSColor) {
        context.setFillColor(color.cgColor)
        context.fill(CGRect(origin: CGPoint.zero, size: animationSize))
    }
}

func capture(_ target :Animation, url :URL) {
    let frameCount = target.frameCount
    
    let fileProperties :[String : [String : Int]] = [kCGImagePropertyGIFDictionary as String : [kCGImagePropertyGIFLoopCount as String : frameCount]]
    let frameProperties :[String : [String : Float]] = [kCGImagePropertyGIFDictionary as String : [kCGImagePropertyGIFDelayTime as String : target.frameDuration]]
    
    let destination = CGImageDestinationCreateWithURL(url as CFURL, kUTTypeGIF, frameCount, nil)
    CGImageDestinationSetProperties(destination!, fileProperties as CFDictionary?)
    
    for _ in 0 ..< frameCount {
        CGImageDestinationAddImage(destination!, captureFrame(target), frameProperties as CFDictionary?)
        target.increment()
    }
    
    CGImageDestinationFinalize(destination!)
}
