// Playground - noun: a place where people can play

import Cocoa
import SwiftGraphics
import SwiftGraphicsPlayground
import XCPlayground

func SGPRender(identifier:String, block:((ctx:CGContext, bounds:CGRect) -> Void)) {
    let demoView = SwiftGraphicsPlayground.DemoView(frame:CGRect(size:CGSize(w:480, h:320)))
    demoView.drawBlock = block
    XCPShowView(identifier, demoView)
}

let r = Random()

var points = Array <CGPoint> (count:50) {
    return r.randomCGPoint(CGRect(w:480, h:320))
}

let hull = monotoneChain(points, presorted:false)

SGPRender("Test") {
    (ctx:CGContext, bounds:CGRect) in
    for (index, point) in enumerate(points) {
        let color = contains(hull, point) ? NSColor.redColor() : NSColor.blackColor()
        color.set()
    
        ctx.strokeCross(CGRect(center:point, radius:5))
        ctx.drawLabel("\(index)", point:point + CGPoint(x:2, y:0), size:10)
    }
    
    ctx.strokeLine(hull, loop:true)
}

extension Array {
    init(count:Int, block:(Void) -> T) {
        self.init()
        for N in 0..<count {
            self.append(block())
        }
    }
}

extension Array {
    mutating func push(o:T) {
        self.append(o)
    }
    mutating func pop() -> T? {
        if let first = self.first {
            self.removeAtIndex(0)
            return first
        }
        return nil
    }
}
