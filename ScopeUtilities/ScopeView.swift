//
//  ScopeView.swift
//  Scope
//
//  Created by Fabian Canas on 12/1/15.
//  Copyright © 2015 Fabián Cañas. All rights reserved.
//

import Cocoa

func captureFrame(target: Animation) -> CGImage {
    let frameSize = target.animationSize
    let offscreenRep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: Int(frameSize.width), pixelsHigh: Int(frameSize.height), bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: NSDeviceRGBColorSpace, bitmapFormat: NSBitmapFormat.NSAlphaFirstBitmapFormat, bytesPerRow: 0, bitsPerPixel: 0)
    
    let ctx = NSGraphicsContext(bitmapImageRep: offscreenRep!)?.CGContext
    
    target.renderInContext(ctx!)
    
    return CGBitmapContextCreateImage(ctx!)!
}

public func captureGifFromWindow(window: NSWindow, captureTarget: Animation) {
    let panel = NSSavePanel()
    panel.nameFieldStringValue = "\(captureTarget.name).gif"
    panel.beginSheetModalForWindow(window, completionHandler: { (result) -> Void in
        if result == NSFileHandlingPanelOKButton {
            capture(captureTarget, url: panel.URL!)
        }
    })
}

@objc public class ScopeView : NSView {
    
    var timer :NSTimer? = nil
    
    @IBOutlet public var captureTarget :Animation! {
        didSet {
            if let timer = self.timer {
                timer.invalidate()
            }
            self.timer =  NSTimer(timeInterval: NSTimeInterval(captureTarget.frameDuration), target: self, selector: #selector(ScopeView.tick(_:)), userInfo: nil, repeats: true)
            NSRunLoop.mainRunLoop().addTimer(self.timer!, forMode: NSDefaultRunLoopMode)
        }
    }
    
    func tick(timer: NSTimer) {
        captureTarget.increment()
        setNeedsDisplayInRect(bounds)
    }
    
    override public var intrinsicContentSize: NSSize { get { return captureTarget.animationSize } }
    
    override public func drawRect(dirtyRect: NSRect) {
        captureTarget.renderInContext(NSGraphicsContext.currentContext()!.CGContext)
    }
    
    @IBAction func captureGif(sender: AnyObject) {
        captureGifFromWindow(self.window!, captureTarget: captureTarget)
    }

}

