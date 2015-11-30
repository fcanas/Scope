//
//  Drawing.swift
//  Scope
//
//  Created by Fabian Canas on 11/29/15.
//  Copyright © 2015 Fabián Cañas. All rights reserved.
//

import Foundation
import CoreGraphics

/// Given a coregraphics function that accepts a context and a rect, 
/// returns a function that accepts a center and a radius.
func centeredCircle(cgFunction: (CGContext?, CGRect) -> Void) -> (context: CGContext, center: CGPoint, radius: CGFloat) -> Void {
    return { (context: CGContext, center: CGPoint, radius: CGFloat) in
        let origin = CGPoint(x: center.x - radius, y: center.y - radius)
        let size = CGSize(width: radius * 2, height: radius * 2)
        cgFunction(context, CGRect(origin: origin, size: size))
    }
}

/// Strokes a circle in the provided context at the provided center with radius
public let strokeCircle = centeredCircle(CGContextStrokeEllipseInRect)
/// Fills a circle in the provided context at the provided center with radius
public let fillCircle = centeredCircle(CGContextFillEllipseInRect)
