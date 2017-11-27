//
//  Spinner.swift
//  Scope
//
//  Created by Fabian Canas on 11/26/17.
//  Copyright © 2017 Fabián Cañas. All rights reserved.
//

import Foundation



import Cocoa
import ScopeUtilities

class Spinner: NSObject, Animation {
    
    let name = "Spinner"
    lazy var frameCount :Int =  {
        return Int(self.maxCounter / CGFloat(self.counterIncrement))
    }()
    let frameDuration :Float = 1/60.0
    let animationSize = CGSize(width: 264, height: 264)
    
    var stroke :Stroke = Stroke()
    let maxCounter :CGFloat = 4 * CGFloat.pi
    let counterIncrement :CGFloat = CGFloat.pi / 40
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
    }
    
    func blades(_ context :CGContext) {
        growShrinkStroke(context, x: -100 * cos(counter / 2), y: -100 * sin(counter / 2))
        context.rotate(by:CGFloat.pi)
        growShrinkStroke(context, x: -100 * cos(counter / 2), y: -100 * sin(counter / 2))
    }
    
    func growShrinkStroke(_ context :CGContext, x: CGFloat, y: CGFloat) {
        var margin :CGFloat = 5
        let point = CGPoint(
            x: x,
            y: y
        )
        
        let mRad :CGFloat = 5
        
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
