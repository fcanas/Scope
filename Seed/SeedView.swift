//
//  SeedView.swift
//  Scope
//
//  Created by Fabian Canas on 12/6/15.
//  Copyright © 2015 Fabián Cañas. All rights reserved.
//

import Cocoa
import ScopeUtilities

@objc class Seed: NSObject, GifCaptureTarget {
    
    let name = "Seed"
    lazy var frameCount :Int = { return Int(1.0 / Float(self.counterIncrement)) }()
    let frameDuration :Float = 1/60.0
    let animationSize = CGSize(width: 400, height: 400)
    
    var counterIncrement :CGFloat = 0.01
    var counter :CGFloat = 0
    
    func renderInContext(context: CGContext) {
        clear(context, color: NSColor.blackColor())
        CGContextTranslateCTM(context, animationSize.width / 2, animationSize.height / 2)
        
        for var i :CGFloat = 0; i < 7; i++ {
            drawSeed(context, scale: pow(3, i + counter))
        }
    }
    
    func increment() {
        counter += counterIncrement
        if counter > 1.0 {
            counter = 0.0
        }
    }
}

func drawSeed(context: CGContext, scale: CGFloat) {
    let s :CGFloat = scale / 3.0
    CGContextScaleCTM(context, s, s)
    CGContextSetStrokeColorWithColor(context, NSColor.whiteColor().CGColor)
    CGContextAddPath(context, seedPath())
    CGContextStrokePath(context)
    CGContextScaleCTM(context, 1/s, 1/s)
}

func seedPath() -> CGPath {
    let path = CGPathCreateMutable()
    
    var identity = CGAffineTransformMakeTranslation(0, 2.75)
    
    CGPathMoveToPoint(path, &identity, 0, 0)
    CGPathAddLineToPoint(path, &identity, -1, -2)
    CGPathAddQuadCurveToPoint(path, &identity, -2, -4, 0, -4)
    CGPathAddQuadCurveToPoint(path, &identity, 2, -4, 1, -2)
    CGPathCloseSubpath(path)
    
    return path
}
