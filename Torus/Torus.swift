//
//  TorusView.swift
//  Scope
//
//  Created by Fabian Canas on 12/5/15.
//  Copyright © 2015 Fabián Cañas. All rights reserved.
//

import Cocoa
import ScopeUtilities

class Torus: NSObject, Animation {
    
    let animationSize = CGSize(width: 450, height: 300)
    let name = "Torus"
    let frameCount = Int(Float.pi * 2 / 0.03)
    let frameDuration :Float = 0.03
    
    var angle :CGFloat = 0.0
    var center = CGPoint(x: 0, y: 0)
    
    func renderInContext(_ context: CGContext) {
        clear(context, color: NSColor.black)
        
        context.translateBy(x: animationSize.width / 2, y: animationSize.height / 2)
        
        context.setStrokeColor(NSColor.white.cgColor)
        
        let height :CGFloat = 100.0
        
        for localAngle in stride(from: 0.0, to: (CGFloat.pi * 2), by: CGFloat.pi / 25) {
            center.x = sin(localAngle) * height * 1.5 * cos(angle * 1.5)
            center.y = (cos(localAngle) * height / 1.5 ) * sin(angle * 1.5)

            context.strokeEllipse(in: rectAtCenter(center, size: CGSize(width: abs(sin(localAngle + CGFloat.pi) * height), height: height)))
        }
    }
    
    func rectAtCenter(_ center: CGPoint, size: CGSize) -> CGRect {
        return CGRect(origin: CGPoint(x: center.x - size.width / 2, y: center.y - size.height / 2), size: size)
    }
    
    func increment() {
        angle += 0.03
        if angle >= (CGFloat.pi * 2) {
            angle -= (CGFloat.pi * 2)
        }
    }
}
