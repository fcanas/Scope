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
    let frameCount = Int(Float.pi * 2 / 0.03)
    let frameDuration :Float = 0.03
    
    var timeIndex :Float = 0
    
    func renderInContext(_ context: CGContext) {
        clear(context, color: NSColor.black)
        context.setFillColor(NSColor.white.cgColor)
        
        context.translateBy(x: animationSize.width / 2, y: animationSize.height / 2)
        context.scaleBy(x: CGFloat(cos(timeIndex) * 10.0), y: CGFloat(cos(timeIndex) * 10.0))
        context.rotate(by: CGFloat(timeIndex * 2))
        
        context.addPath(star(10, outer: 20, pointCount: 10))
        
        context.fillPath()
    }
    
    func star(_ inner: CGFloat, outer: CGFloat, pointCount :Int) -> CGPath {
        let path = CGMutablePath()
        var angle :CGFloat = 0
        path.move(to: CGPoint(x: cos(angle) * inner, y: sin(angle) * inner))
        while angle < CGFloat.pi * 2 {
            angle += (CGFloat.pi * 2) / CGFloat(pointCount * 2)
            path.addLine(to: CGPoint(x:cos(angle) * outer, y:sin(angle) * outer))
            angle += (CGFloat.pi * 2) / CGFloat(pointCount * 2)
            path.addLine(to: CGPoint(x:cos(angle) * inner, y:sin(angle) * inner))
        }
        return path
    }
    
    func increment() {
        timeIndex += 0.03
        if timeIndex >= Float.pi * 2 {
            timeIndex -= Float.pi * 2
        }
    }
}
