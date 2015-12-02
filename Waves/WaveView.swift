//
//  WaveView.swift
//  Scope
//
//  Created by Fabian Canas on 11/29/15.
//  Copyright © 2015 Fabián Cañas. All rights reserved.
//

import Cocoa
import ScopeUtilities

class WaveView: NSView, GifCaptureTarget {
    
    let orbitColor = NSColor.lightGrayColor()
    let satelliteColor = NSColor.blackColor()
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let timer =  NSTimer(timeInterval: 1.0/30.0, target: self, selector: Selector("tick:"), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
    }
    
    let name = "Waves"
    var frameCount :Int = Int(CGFloat(M_PI * 2) / 0.1)
    var frameDuration :Float = 0.02
    let animationSize :CGSize = CGSize(width: 410, height: 410)
    
    func increment() {
        p += stepSize
        p %= modBase
    }
    
    var p :CGFloat = 0.0
    let stepSize :CGFloat = 0.1
    let modBase = CGFloat(M_PI * 2)
    
    func tick(timer: NSTimer) {
        increment()
        setNeedsDisplayInRect(bounds)
    }
    
    override func drawRect(dirtyRect: NSRect) {
        let ctx = NSGraphicsContext.currentContext()!.CGContext
        renderInContext(ctx)
    }
    
    func renderInContext(context: CGContext) {
        for var x = 30; x < 400; x += 35 {
            for var y = 30; y < 400; y += 35 {
                drawOrbit(context, center: CGPoint(x: x, y: y), radius: 13, satRadius: 5, satPhase: p + CGFloat(x) / 100.0 + CGFloat(y) / 100.0)
            }
        }
    }
    
    func drawOrbit(context: CGContext, center :CGPoint, radius: CGFloat, satRadius: CGFloat, satPhase: CGFloat) {
        CGContextSetStrokeColorWithColor(context, orbitColor.CGColor)
        strokeCircle(context: context, center: center, radius: radius)
        
        CGContextSetFillColorWithColor(context, satelliteColor.CGColor)
        
        let sx = sin(satPhase) * radius + center.x
        let sy = cos(satPhase) * radius + center.y
        
        let satCenter = CGPoint(x: sx, y: sy)
        fillCircle(context: context, center: satCenter, radius: satRadius)
    }
    
    @IBAction func captureGif(sender: AnyObject) {
        captureGifFromWindow(self.window!, captureTarget: self)
    }
    
}
