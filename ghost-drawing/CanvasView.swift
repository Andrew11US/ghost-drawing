//
//  CanvasView.swift
//  ghost-drawing
//
//  Created by Andrew on 2022-07-21.
//

import UIKit

class CanvasView: UIView {
    private var lines: [Line] = []
    private var strokeWidth: CGFloat = 8.0
    var strokeColor: UIColor = .red
    
    // MARK: - Drawing methods
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        lines.forEach { line in
            context.setStrokeColor(line.strokeColor.cgColor)
            context.setLineWidth(line.strokeWidth)
            context.setLineCap(.round)
            
            for (index, point) in line.points.enumerated() {
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
        guard let point = touches.first?.location(in: self) else { return }
        
        let newLine = Line(points: [point], strokeColor: strokeColor, strokeWidth: strokeWidth)
        lines.append(newLine)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }
        guard var lastLine = lines.popLast() else { return }
        
        lastLine.points.append(point)
        lines.append(lastLine)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let delay = DispatchTime.now() + DispatchTimeInterval.seconds(strokeColor.delay)
        DispatchQueue.main.asyncAfter(deadline: delay) {
            self.setNeedsDisplay()
        }
    }
}
