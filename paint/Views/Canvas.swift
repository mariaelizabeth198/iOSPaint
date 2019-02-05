//
//  Canvas.swift
//  paint
//
//  Created by Maria Elizabeth Da Silva Bezerra on 05/02/2019.
//  Copyright © 2019 Maria Elizabeth. All rights reserved.
//

import UIKit

class Canvas: UIView {
    var lines = [[CGPoint]]()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {return}
        
        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineWidth(10)
        context.setLineCap(.butt)
        
        lines.forEach { (line) in
            for (index, point) in line.enumerated() {
                if index == 0 {
                    context.move(to: point)
                } else {
                    context.addLine(to: point)
                }
            }
        }
        
        context.strokePath()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let point = touches.first?.location(in: nil) else {return}
        
        guard var lastLine = lines.popLast() else {return}
        lastLine.append(point)
        lines.append(lastLine)
        
        setNeedsDisplay()
    }
}
