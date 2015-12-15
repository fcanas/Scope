//
//  Animation.swift
//  Scope
//
//  Created by Fabian Canas on 12/14/15.
//  Copyright © 2015 Fabián Cañas. All rights reserved.
//

import Foundation

@objc public protocol Animation {
    var name :String { get }
    var frameCount :Int { get }
    var frameDuration :Float { get }
    var animationSize :CGSize { get }
    
    func renderInContext(context: CGContext)
    func increment()
}

public extension Animation {
    public func clear(context: CGContext, color: NSColor) {
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, CGRect(origin: CGPoint.zero, size: animationSize))
    }
}

func capture(target :Animation, url :NSURL) {
    let frameCount = target.frameCount
    
    let fileProperties :[String : [String : Int]] = [kCGImagePropertyGIFDictionary as String : [kCGImagePropertyGIFLoopCount as String : frameCount]]
    let frameProperties :[String : [String : Float]] = [kCGImagePropertyGIFDictionary as String : [kCGImagePropertyGIFDelayTime as String : target.frameDuration]]
    
    let destination = CGImageDestinationCreateWithURL(url, kUTTypeGIF, frameCount, nil)
    CGImageDestinationSetProperties(destination!, fileProperties)
    
    for var frame = 0; frame < frameCount; frame++ {
        CGImageDestinationAddImage(destination!, captureFrame(target), frameProperties)
        target.increment()
    }
    
    CGImageDestinationFinalize(destination!)
}
