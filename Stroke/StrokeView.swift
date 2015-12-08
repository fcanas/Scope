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

    var stroke = Array<CGPoint>()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        animationSize = CGSize(width: 400, height: 400)
        name = "Stroke"
        frameCount = Int(maxCounter / CGFloat(counterIncrement))
        frameDuration = 1/60.0
    }
    
    let maxCounter :CGFloat = 2 * CGFloat(M_PI)
    var counterIncrement :CGFloat = 0.01
    var counter :CGFloat = 0

    override func renderInContext(context: CGContext) {
        clear(context, color: NSColor.blackColor())
        
        for var dot = 0; dot < stroke.count; dot++ {
            fillCircle(context: context, center: stroke[dot], radius: sin(CGFloat(dot) * CGFloat(M_PI) / CGFloat(stroke.count)))
        }
        
        
    }
    
    override func increment() {
        counter += counterIncrement
        if counter > maxCounter {
            counter = 0.0
        }
    }
    
}
