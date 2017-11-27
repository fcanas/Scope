//
//  SeedView.swift
//  Scope
//
//  Created by Fabian Canas on 12/6/15.
//  Copyright © 2015 Fabián Cañas. All rights reserved.
//

import Cocoa
import ScopeUtilities

@objc class Seed: NSObject, Animation {
    
    let name = "Seed"
    lazy var frameCount :Int = { return Int(1.0 / Float(self.counterIncrement)) }()
    let frameDuration :Float = 1/60.0
    let animationSize = CGSize(width: 400, height: 400)
    
    var counterIncrement :CGFloat = 0.01
    var counter :CGFloat = 0
    
    func reset() {
        counter = 0
    }
    
    func renderInContext(_ context: CGContext) {
        clear(context, color: NSColor.black)
        context.translateBy(x: animationSize.width / 2, y: animationSize.height / 2)
        
        for i in 0 ..< 7 {
            drawSeed(context, scale: pow(3, CGFloat(i) + counter))
        }
    }
    
    func increment() {
        counter += counterIncrement
        if counter > 1.0 {
            counter = 0.0
        }
    }
}

func drawSeed(_ context: CGContext, scale: CGFloat) {
    let s :CGFloat = scale / 3.0
    context.scaleBy(x: s, y: s)
    context.setStrokeColor(NSColor.white.cgColor)
    context.addPath(seedPath())
    context.strokePath()
    context.scaleBy(x: 1/s, y: 1/s)
}

func seedPath() -> CGPath {
    let path = CGMutablePath()
    
    let identity = CGAffineTransform(translationX: 0, y: 2.75)
    
    path.move(to: .zero, transform: identity)
    path.addLine(to: CGPoint(x:-1, y:-2), transform: identity)
    path.addQuadCurve(to: CGPoint(x:0, y:-4), control: CGPoint(x:-2,y:-4), transform: identity)
    path.addQuadCurve(to: CGPoint(x:1, y:-2), control: CGPoint(x:2,y:-4), transform: identity)
    path.closeSubpath()
    
    return path
}
