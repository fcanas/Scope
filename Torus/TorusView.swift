//
//  TorusView.swift
//  Scope
//
//  Created by Fabian Canas on 12/5/15.
//  Copyright © 2015 Fabián Cañas. All rights reserved.
//

import Cocoa
import ScopeUtilities

class TorusView: ScopeView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        animationSize = CGSize(width: 450, height: 300)
        name = "Torus"
        frameCount = Int(Float(M_PI) * 2 / 0.03)
        frameDuration = 0.03
    }
    
    var angle :CGFloat = 0.0
    var center = CGPoint(x: 0, y: 0)
    
    override func renderInContext(context: CGContext) {
        clear(context, color: NSColor.blackColor())
        
        CGContextTranslateCTM(context, animationSize.width / 2, animationSize.height / 2)
        
        CGContextSetStrokeColorWithColor(context, NSColor.whiteColor().CGColor)
        
        let height :CGFloat = 100.0
        
        for var localAngle :CGFloat = 0.0; localAngle < CGFloat(M_PI * 2); localAngle += CGFloat(M_PI / 25) {
            center.x = sin(localAngle) * height * 1.5 * cos(angle * 1.5)
            center.y = (cos(localAngle) * height / 1.5 ) * sin(angle * 1.5)

            CGContextStrokeEllipseInRect(context, rectAtCenter(center, size: CGSize(width: abs(sin(localAngle + CGFloat(M_PI)) * height), height: height)))
        }
    }
    
    func rectAtCenter(center: CGPoint, size: CGSize) -> CGRect {
        return CGRect(origin: CGPoint(x: center.x - size.width / 2, y: center.y - size.height / 2), size: size)
    }
    
    override func increment() {
        angle += 0.03
        if angle >= CGFloat(M_PI * 2) {
            angle -= CGFloat(M_PI * 2)
        }
    }
}
