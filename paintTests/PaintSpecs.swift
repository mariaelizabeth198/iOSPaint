//
//  PaintSpecs.swift
//  paintTests
//
//  Created by Maria Elizabeth Da Silva Bezerra on 07/02/2019.
//  Copyright © 2019 Maria Elizabeth. All rights reserved.
//

import Quick
import Nimble

@testable import paint

class PaintSpecs: QuickSpec {
    
    override func spec() {
        var canvas: Canvas!
        
        describe("Drawing") {
            context("validate methods of canvas") {
                beforeEach {
                    canvas = Canvas()
                }
                
                afterEach {
                    canvas = nil
                }
                
                it("can see the background white") {
                    expect(canvas?.backgroundColor) == .white
                }
                
                it("can undo the last line") {
                    let firstLine = Line.init(strokeWidth: 10, color: UIColor.green, points: [])
                    let lastLine = Line.init(strokeWidth: 9, color: UIColor.red, points: [])
                    
                    canvas.lines.append(firstLine)
                    canvas.lines.append(lastLine)
                    
                    canvas.undo()

                    expect(canvas.lines.count) == 1
                    expect(canvas.lines.last?.color) == firstLine.color
                }
                
                it("can clear the entire drawing") {
                    let firstLine = Line.init(strokeWidth: 10, color: UIColor.black, points: [])
                    let lastLine = Line.init(strokeWidth: 9, color: UIColor.red, points: [])
                    
                    canvas.lines.append(firstLine)
                    canvas.lines.append(lastLine)
                    
                    canvas.clear()
                    
                    expect(canvas.lines.count) == 0
                }
                
                it("can set the stroke color of line") {
                    canvas.strokeColor = .white
                    let expectedColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
                    
                    canvas.setStrokeColor(r: 0, g: 0, b: 0)
                    
                    expect(canvas.strokeColor) == expectedColor
                }
                
                it("can set the stroke width of line") {
                    canvas.strokeWidth = 1.0
                    let expectedStrokeWidth: Float = 100.0
                    
                    canvas.setStrokeWidth(width: expectedStrokeWidth)
                    
                    expect(canvas.strokeWidth) == expectedStrokeWidth
                }
                
                it("can draw a line when the thouches began") {
                    canvas.strokeColor = UIColor.blue
                    canvas.strokeWidth = 100.0
                    
                    canvas.touchesBegan(Set<UITouch>(), with: UIEvent())
                    
                    expect(canvas.lines.last?.color) == canvas.strokeColor
                    expect(canvas.lines.last?.strokeWidth) == canvas.strokeWidth
                }
                
                it("can draw a line when the touches moved") {
                    let firstLine = Line.init(strokeWidth: 10, color: UIColor.black, points: [])
                    let lastLine = Line.init(strokeWidth: 9, color: UIColor.red, points: [])
                    
                    canvas.lines.append(firstLine)
                    canvas.lines.append(lastLine)
                    
                    let touch: UITouch = UITouch()
                    
                    var set = Set<UITouch>()
                    set.insert(touch)
                    
                    canvas.touchesMoved(set, with: UIEvent())
                    
                    expect(canvas.lines.last?.points.first) == touch.location(in: UIView())
                }
            }
        }
    }
}
