//
//  WaveView.swift
//  Scope
//
//  Created by Fabian Canas on 11/29/15.
//  Copyright © 2015 Fabián Cañas. All rights reserved.
//

import Cocoa
import ScopeUtilities

class WaveView: NSView, Animation {
    
    let orbitColor = NSColor.lightGrayColor()
    let satelliteColor = NSColor.blackColor()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let timer =  NSTimer(timeInterval: 1.0/30.0, target: self, selector: Selector("tick:"), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
    }
    
    let name = "Waves"
    var frameCount :Int = Int((CGFloat.pi * 2) / 0.1)
    var frameDuration :Float = 0.02
    let animationSize :CGSize = CGSize(width: 520, height: 520)
    
    func increment() {
        p += stepSize
        p %= modBase
    }
    
    var p :CGFloat = 0.0
    let stepSize :CGFloat = 0.1
    let modBase = (CGFloat.pi * 2)
    
    func tick(timer: NSTimer) {
        increment()
        setNeedsDisplayInRect(bounds)
    }
    
    override func drawRect(dirtyRect: NSRect) {
        let ctx = NSGraphicsContext.currentContext()!.CGContext
        renderInContext(ctx)
    }
    
    func renderInContext(context: CGContext) {
        for var x = 35; x < 500; x += 30 {
            for var y = 35; y < 500; y += 30 {
                drawOrbit(context, center: CGPoint(x: x, y: y), radius: 30, satRadius: 5, satPhase: p + CGFloat(x) / 85.0 + CGFloat(y) / 85.0)
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
    
    override var intrinsicContentSize: NSSize { get { return animationSize } }
}
