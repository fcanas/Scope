# Scope

A place to doodle with Swift

## Torus
![](https://github.com/fcanas/Scope/blob/master/Torus/Torus.gif?raw=true)

[torus source](https://github.com/fcanas/Scope/blob/master/Torus/TorusView.swift)

## Star
![](https://github.com/fcanas/Scope/blob/master/Star/Star.gif?raw=true).

```swift
func star(inner: CGFloat, outer: CGFloat, pointCount :Int) -> CGPath {
    let path = CGPathCreateMutable()
    var identity = CGAffineTransformIdentity
    var angle :CGFloat = 0
    CGPathMoveToPoint(path, &identity, cos(angle) * inner, sin(angle) * inner)
    while angle < CGFloat(M_PI) * 2 {
        angle += CGFloat(M_PI * 2) / CGFloat(pointCount * 2)
        CGPathAddLineToPoint(path, &identity, cos(angle) * outer, sin(angle) * outer)
        angle += CGFloat(M_PI * 2) / CGFloat(pointCount * 2)
        CGPathAddLineToPoint(path, &identity, cos(angle) * inner, sin(angle) * inner)
    }
    return path
}

CGContextSetFillColorWithColor(context, NSColor.whiteColor().CGColor)
CGContextTranslateCTM(context, animationSize.width / 2, animationSize.height / 2)
CGContextScaleCTM(context, CGFloat(cos(timeIndex) * 10.0), CGFloat(cos(timeIndex) * 10.0))
CGContextRotateCTM(context, CGFloat(timeIndex * 2))
CGContextAddPath(context, star(10, outer: 20, pointCount: 10))
CGContextFillPath(context)
```

## Waves
Shamelessly copying [Bees & Bombs](http://beesandbombs.tumblr.com/post/134366721074/ok-couldnt-resist-remaking-this-old-chestnut-in)

![](https://github.com/fcanas/Scope/blob/master/Waves/Waves.gif?raw=true).

```swift
func drawOrbit(context: CGContext, center :CGPoint, radius: CGFloat, satRadius: CGFloat, satPhase: CGFloat) {
    CGContextSetStrokeColorWithColor(context, orbitColor.CGColor)
    strokeCircle(context: context, center: center, radius: radius)
    
    CGContextSetFillColorWithColor(context, satelliteColor.CGColor)
    
    let sx = sin(satPhase) * radius + center.x
    let sy = cos(satPhase) * radius + center.y
    
    let satCenter = CGPoint(x: sx, y: sy)
    fillCircle(context: context, center: satCenter, radius: satRadius)
}

for var x = 30; x < 400; x += 35 {
    for var y = 30; y < 400; y += 35 {
        drawOrbit(context, center: CGPoint(x: x, y: y), radius: 13, satRadius: 5, satPhase: p + CGFloat(x) / 100.0 + CGFloat(y) / 100.0)
    }
}
```
