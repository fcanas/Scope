//
//  StrokeView.swift
//  Scope
//
//  Created by Fabian Canas on 12/6/15.
//  Copyright © 2015 Fabián Cañas. All rights reserved.
//

import Cocoa
import ScopeUtilities

class StrokeView: ScopeView {

    var stroke :Stroke = Stroke()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        animationSize = CGSize(width: 400, height: 400)
        name = "Stroke"
        frameCount = Int(maxCounter / CGFloat(counterIncrement))
        frameDuration = 1/30.0
    }
    
    let maxCounter :CGFloat = 3 * CGFloat(M_PI)
    var counterIncrement :CGFloat = 0.18
    var counter :CGFloat = 0

    override func renderInContext(context: CGContext) {
        clear(context, color: NSColor.blackColor())
        
        CGContextTranslateCTM(context, animationSize.width / 2, animationSize.height / 2)
        CGContextRotateCTM(context, counter)
        
        blades(context)
        
        CGContextScaleCTM(context, counter / 2, counter / 2)
        
        blades(context)
        
        CGContextScaleCTM(context, counter / 2, counter / 2)
        
        blades(context)

    }
    
    func blades(context :CGContext) {
        growShrinkStroke(context, x: 30 * cos(counter) * counter, y: 30 * sin(counter) * counter)
        growShrinkStroke(context, x: 30 * sin(counter) * counter, y: 30 * cos(counter) * counter)
        
        growShrinkStroke(context, x: -30 * cos(counter) * counter, y: -30 * sin(counter) * counter)
        growShrinkStroke(context, x: -30 * sin(counter) * counter, y: -30 * cos(counter) * counter)
    }
    
    func growShrinkStroke(context :CGContext, x: CGFloat, y: CGFloat) {
        var margin :CGFloat = 15
        let point = CGPoint(
            x: x,
            y: y
        )
        
        let mRad :CGFloat = 10
        
        if counter == 0.0 {
            stroke = Stroke()
        }
        
        if counter < CGFloat(M_PI) {
            margin = mRad * counter / CGFloat(M_PI)
            stroke = stroke.grow(point)
        } else if counter < CGFloat(2 * M_PI) {
            stroke = stroke.advance(stroke, point: point)
            margin = mRad
        } else {
            stroke = stroke.shrink()
            margin = mRad * (1.0 - ((counter - CGFloat(M_PI) * 2) / CGFloat(M_PI)))
        }
        dotBrush(context, stroke: stroke, color: NSColor.whiteColor().CGColor, maxRadius: margin)
    }
    
    override func increment() {
        counter += counterIncrement
        if counter > maxCounter {
            counter = 0.0
        }
    }
    
}
