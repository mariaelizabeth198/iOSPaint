//
//  paintTests.swift
//  paintTests
//
//  Created by Maria Elizabeth Da Silva Bezerra on 05/02/2019.
//  Copyright © 2019 Maria Elizabeth. All rights reserved.
//

import XCTest
@testable import paint

var canvas: Canvas!

class paintTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        canvas = Canvas()
    }
    
    override func tearDown() {
        canvas = nil
        super.tearDown()
    }
    
    func testBackgroundIsWhite() {
        //given
        let expectedBackgroundColor: UIColor = .white
        
        //when
        //then
        XCTAssertEqual(canvas.backgroundColor, expectedBackgroundColor)
    }
    
    func testUndoIsPopLast() {
        //given
        let firstLine = Line.init(strokeWidth: 10, color: UIColor.black, points: [])
        let lastLine = Line.init(strokeWidth: 9, color: UIColor.red, points: [])
        
        canvas.lines.append(firstLine)
        canvas.lines.append(lastLine)
        
        //when
        canvas.undo()
        
        //then
        XCTAssertEqual(canvas.lines.count, 1)
        XCTAssertEqual(canvas.lines.last?.color, firstLine.color)
    }
    
    func testClearIsRemoveAll() {
        //given
        let firstLine = Line.init(strokeWidth: 10, color: UIColor.black, points: [])
        let lastLine = Line.init(strokeWidth: 9, color: UIColor.red, points: [])
        
        canvas.lines.append(firstLine)
        canvas.lines.append(lastLine)
        
        //then
        canvas.clear()
        
        //when
        XCTAssertEqual(canvas.lines.count, 0)
    }
    
    func testSetStrokeColor() {
        //given
        canvas.strokeColor = .white
        let expectedColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        
        //when
        canvas.setStrokeColor(r: 0, g: 0, b: 0)
        
        //then
        XCTAssertEqual(canvas.strokeColor, expectedColor)
    }
    
    func testSetStrokeWidth() {
        //given
        canvas.strokeWidth = 1.0
        let expectedStrokeWidth: Float = 100.0
        
        //when
        canvas.setStrokeWidth(width: expectedStrokeWidth)
        
        //then
        XCTAssertEqual(canvas.strokeWidth, expectedStrokeWidth)
    }
    
    func testTouchesBegan() {
        //given
        canvas.strokeColor = UIColor.blue
        canvas.strokeWidth = 100.0
        
        //when
        canvas.touchesBegan(Set<UITouch>(), with: UIEvent())
        
        //then
        XCTAssertEqual(canvas.lines.last?.color, canvas.strokeColor)
        XCTAssertEqual(canvas.lines.last?.strokeWidth, canvas.strokeWidth)
    }
}
