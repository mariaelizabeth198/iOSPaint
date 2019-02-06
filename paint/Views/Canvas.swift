//
//  Canvas.swift
//  paint
//
//  Created by Maria Elizabeth Da Silva Bezerra on 05/02/2019.
//  Copyright © 2019 Maria Elizabeth. All rights reserved.
//

import UIKit

class Canvas: UIView { 
    private var lines = [Line]()
    private var strokeColor: UIColor = UIColor.black
    private let rgbMaximum: CGFloat = 255.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    func setStrokeColor(r: CGFloat, g: CGFloat , b:CGFloat) {
        strokeColor = UIColor(red: r/rgbMaximum, green: g/rgbMaximum, blue: b/rgbMaximum, alpha: 1.0)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {return}
        
        context.setLineWidth(10)
        context.setLineCap(.butt)
        
        lines.forEach { (line) in
            context.setStrokeColor(line.color.cgColor)
            for(index, point) in line.points.enumerated() {
                if index == 0 {
                    context.move(to: point)
                } else {
                    context.addLine(to: point)
                }
            }
            context.strokePath()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line.init(color: strokeColor, points: []))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else {return}
        
        guard var lastLine = lines.popLast() else {return}
        lastLine.points.append(point)
        lines.append(lastLine)
        
        setNeedsDisplay()
    }
}
