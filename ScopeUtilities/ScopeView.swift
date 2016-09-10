//
//  ScopeView.swift
//  Scope
//
//  Created by Fabian Canas on 12/1/15.
//  Copyright © 2015 Fabián Cañas. All rights reserved.
//

import Cocoa

func captureFrame(_ target: Animation) -> CGImage {
    let frameSize = target.animationSize
    let offscreenRep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: Int(frameSize.width), pixelsHigh: Int(frameSize.height), bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: NSDeviceRGBColorSpace, bitmapFormat: NSBitmapFormat.alphaFirst, bytesPerRow: 0, bitsPerPixel: 0)
    
    let ctx = NSGraphicsContext(bitmapImageRep: offscreenRep!)?.cgContext
    
    target.renderInContext(ctx!)
    
    return ctx!.makeImage()!
}

public func captureGifFromWindow(_ window: NSWindow, captureTarget: Animation) {
    let panel = NSSavePanel()
    panel.nameFieldStringValue = "\(captureTarget.name).gif"
    panel.beginSheetModal(for: window, completionHandler: { (result) -> Void in
        if result == NSFileHandlingPanelOKButton {
            capture(captureTarget, url: panel.url!)
        }
    })
}

@objc open class ScopeView : NSView {
    
    var timer :Timer? = nil
    
    @IBOutlet open var captureTarget :Animation! {
        didSet {
            if let timer = self.timer {
                timer.invalidate()
            }
            self.timer =  Timer(timeInterval: TimeInterval(captureTarget.frameDuration), target: self, selector: #selector(ScopeView.tick(_:)), userInfo: nil, repeats: true)
            RunLoop.main.add(self.timer!, forMode: RunLoopMode.defaultRunLoopMode)
        }
    }
    
    func tick(_ timer: Timer) {
        captureTarget.increment()
        setNeedsDisplay(bounds)
    }
    
    override open var intrinsicContentSize: NSSize { get { return captureTarget.animationSize } }
    
    override open func draw(_ dirtyRect: NSRect) {
        captureTarget.renderInContext(NSGraphicsContext.current()!.cgContext)
    }
    
    @IBAction func captureGif(_ sender: AnyObject) {
        captureGifFromWindow(self.window!, captureTarget: captureTarget)
    }

}

