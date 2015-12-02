//
//  ScopeView.swift
//  Scope
//
//  Created by Fabian Canas on 12/1/15.
//  Copyright © 2015 Fabián Cañas. All rights reserved.
//

import Cocoa

public protocol GifCaptureTarget {
    var name :String { get }
    var frameCount :Int { get }
    var frameDuration :Float { get }
    var animationSize :CGSize { get }
    
    func renderInContext(context: CGContext)
    func increment()
}

func captureFrame(target: GifCaptureTarget) -> CGImage {
    let frameSize = target.animationSize
    let offscreenRep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: Int(frameSize.width), pixelsHigh: Int(frameSize.height), bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: NSDeviceRGBColorSpace, bitmapFormat: NSBitmapFormat.NSAlphaFirstBitmapFormat, bytesPerRow: 0, bitsPerPixel: 0)
    
    let ctx = NSGraphicsContext(bitmapImageRep: offscreenRep!)?.CGContext
    
    target.renderInContext(ctx!)
    
    return CGBitmapContextCreateImage(ctx!)!
}

func capture(target :GifCaptureTarget, url :NSURL) {
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

public func captureGifFromWindow(window: NSWindow, captureTarget: GifCaptureTarget) {
    let panel = NSSavePanel()
    panel.nameFieldStringValue = "\(captureTarget.name).gif"
    panel.beginSheetModalForWindow(window, completionHandler: { (result) -> Void in
        if result == NSFileHandlingPanelOKButton {
            capture(captureTarget, url: panel.URL!)
        }
    })
}

