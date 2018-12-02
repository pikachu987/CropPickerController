//Copyright (c) 2018 pikachu987 <pikachu77769@gmail.com>
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.

import UIKit

// ProgressView
class ProgressView: UIView {
    static var textColor = UIColor.white
    static var progressColor = UIColor(white: 206/255, alpha: 1)
    static var progressTintColor = UIColor(red: 15/255, green: 148/255, blue: 252/255, alpha: 1)
    static var progressBackgroundColor = UIColor.black
    
    
    private var progress: CGFloat = 0
    
    private lazy var label: UILabel = {
        let label = UILabel()
        self.addSubview(label)
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = ProgressView.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        self.centerXConstraint(subView: label)
        self.centerYConstraint(subView: label)
        return label
    }()
    
    func setProgress(_ progress: CGFloat) {
        self.progress = progress
        self.label.text = String(format: "%.1f", progress*100).appending("%")
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = 25
        self.clipsToBounds = true
        
        let bezierPath = UIBezierPath(rect: rect)
        ProgressView.progressBackgroundColor.setFill()
        bezierPath.fill()
        bezierPath.close()
        
        let center = CGPoint(x: rect.width/2, y: rect.height/2)
        
        let backgroundBezierPath = UIBezierPath()
        backgroundBezierPath.addArc(withCenter: center, radius: rect.width/2-1.5, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        backgroundBezierPath.lineWidth = 3
        ProgressView.progressColor.set()
        backgroundBezierPath.stroke()
        backgroundBezierPath.close()
        
        let foregroundBezierPath = UIBezierPath()
        let startAngle = CGFloat.pi * 3.5
        let endAngle = startAngle + (CGFloat.pi * 2 * self.progress)
        foregroundBezierPath.addArc(withCenter: center, radius: rect.width/2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        foregroundBezierPath.lineWidth = 8
        foregroundBezierPath.lineJoinStyle = .miter
        ProgressView.progressTintColor.set()
        foregroundBezierPath.stroke()
        foregroundBezierPath.close()
    }
}
