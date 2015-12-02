# Scope

A place to doodle with Swift

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
