//
//  StrokeView.swift
//  Scope
//
//  Created by Fabian Canas on 12/6/15.
//  Copyright © 2015 Fabián Cañas. All rights reserved.
//

import Cocoa
import ScopeUtilities

class StrokeAnimation: NSObject, Animation {

    let name = "Stroke"
    lazy var frameCount :Int =  {
        return Int(self.maxCounter / CGFloat(self.counterIncrement))
    }()
    let frameDuration :Float = 1/30.0
    let animationSize = CGSize(width: 400, height: 400)
    
    var stroke :Stroke = Stroke()
    let maxCounter :CGFloat = 3 * CGFloat.pi
    let counterIncrement :CGFloat = 0.18
    var counter :CGFloat = 0
    
    func reset() {
        counter = 0
        stroke = Stroke()
    }
    
    func renderInContext(_ context: CGContext) {
        clear(context, color: NSColor.black)
        
        context.translateBy(x: animationSize.width / 2, y: animationSize.height / 2)
        context.rotate(by: counter)
        
        blades(context)
        
        context.scaleBy(x: counter / 2, y: counter / 2)
        
        blades(context)
        
        context.scaleBy(x: counter / 2, y: counter / 2)
        
        blades(context)

    }
    
    func blades(_ context :CGContext) {
        growShrinkStroke(context, x: 30 * cos(counter) * counter, y: 30 * sin(counter) * counter)
        growShrinkStroke(context, x: 30 * sin(counter) * counter, y: 30 * cos(counter) * counter)
        
        growShrinkStroke(context, x: -30 * cos(counter) * counter, y: -30 * sin(counter) * counter)
        growShrinkStroke(context, x: -30 * sin(counter) * counter, y: -30 * cos(counter) * counter)
    }
    
    func growShrinkStroke(_ context :CGContext, x: CGFloat, y: CGFloat) {
        var margin :CGFloat = 15
        let point = CGPoint(
            x: x,
            y: y
        )
        
        let mRad :CGFloat = 10
        
        if counter == 0.0 {
            stroke = Stroke()
        }
        
        if counter < CGFloat.pi {
            margin = mRad * counter / CGFloat.pi
            stroke = stroke.grow(point)
        } else if counter < CGFloat.pi * 2 {
            stroke = stroke.advance(stroke, point: point)
            margin = mRad
        } else {
            stroke = stroke.shrink()
            margin = mRad * (1.0 - ((counter - CGFloat.pi * 2) / CGFloat.pi))
        }
        dotBrush(context, stroke: stroke, color: NSColor.white.cgColor, maxRadius: margin)
    }
    
    func increment() {
        counter += counterIncrement
        if counter > maxCounter {
            counter = 0.0
        }
    }
    
}
