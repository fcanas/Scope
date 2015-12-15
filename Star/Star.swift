//
//  Star.swift
//  Scope
//
//  Created by Fabian Canas on 12/4/15.
//  Copyright © 2015 Fabián Cañas. All rights reserved.
//

import Cocoa
import ScopeUtilities

class Star: NSObject, Animation {
    
    let animationSize = CGSize(width: 400, height: 400)
    let name = "Star"
    let frameCount = Int(Float(M_PI) * 2 / 0.03)
    let frameDuration :Float = 0.03
    
    var timeIndex :Float = 0
    
    func renderInContext(context: CGContext) {
        clear(context, color: NSColor.blackColor())
        CGContextSetFillColorWithColor(context, NSColor.whiteColor().CGColor)
        
        CGContextTranslateCTM(context, animationSize.width / 2, animationSize.height / 2)
        CGContextScaleCTM(context, CGFloat(cos(timeIndex) * 10.0), CGFloat(cos(timeIndex) * 10.0))
        CGContextRotateCTM(context, CGFloat(timeIndex * 2))
        
        CGContextAddPath(context, star(10, outer: 20, pointCount: 10))
        
        CGContextFillPath(context)
    }
    
    func star(inner: CGFloat, outer: CGFloat, pointCount :Int) -> CGPath {
        let path = CGPathCreateMutable()
        var identity = CGAffineTransformIdentity
        var angle :CGFloat = 0
        CGPathMoveToPoint(path, &identity, cos(angle) * inner, sin(angle) * inner)
        while angle < CGFloat(M_PI) * 2 {
            angle += CGFloat(M_PI * 2) / CGFloat(pointCount * 2)
            CGPathAddLineToPoint(path, &identity, cos(angle) * outer, sin(angle) * outer)
            angle += CGFloat(M_PI * 2) / CGFloat(pointCount * 2)
            CGPathAddLineToPoint(path, &identity, cos(angle) * inner, sin(angle) * inner)
        }
        return path
    }
    
    func increment() {
        timeIndex += 0.03
        if timeIndex >= Float(M_PI) * 2 {
            timeIndex -= Float(M_PI) * 2
        }
    }
}
