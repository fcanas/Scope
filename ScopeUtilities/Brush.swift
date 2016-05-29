//
//  Brush.swift
//  Scope
//
//  Created by Fabian Canas on 12/8/15.
//  Copyright © 2015 Fabián Cañas. All rights reserved.
//

import Foundation
import CoreGraphics

public struct Stroke {
    let points :Array<CGPoint>
    
    public init() {
        points = Array()
    }
    
    init(points: Array<CGPoint>) {
        self.points = points
    }
    
    public func grow(point: CGPoint) -> Stroke {
        var points = self.points
        points.append(point)
        return Stroke(points: points)
    }
    
    public func shrink() -> Stroke {
        var points = self.points
        if points.count > 0 {
            points.removeFirst()
        }
        return Stroke(points: points)
    }
    
    public func advance(stroke: Stroke, point: CGPoint) -> Stroke {
        return shrink().grow(point)
    }
}

public func dotBrush(context: CGContext, stroke: Stroke, color: CGColor, maxRadius: CGFloat) {
    CGContextSetFillColorWithColor(context, color)
    for (index, point) in stroke.points.enumerate() {
        let radius = sin(CGFloat(index) / CGFloat(stroke.points.count) * CGFloat(M_PI)) * maxRadius
        fillCircle(context: context, center: point, radius: radius)
    }
}
