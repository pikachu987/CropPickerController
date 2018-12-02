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

// Make Camera Image
class CameraView: UIView {
    
    private var color: UIColor
    
    init(_ color: UIColor) {
        self.color = color
        super.init(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        self.setNeedsDisplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.color = .black
        super.init(coder: aDecoder)
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        self.backgroundColor = .clear
        let path = UIBezierPath()
            .move(1, 7)
            .line(13, 7)
            .line(15, 4)
            .line(25, 4)
            .line(27, 7)
            .line(39, 7)
            .line(39, 35)
            .line(1, 35)
            .line(1, 7)
        path.closed()
            .stroke(self.color)
        
        let smallCirclePath = UIBezierPath()
        smallCirclePath.addArc(withCenter: CGPoint(x: 8, y: 13), radius: 2, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
        smallCirclePath.closed()
            .stroke(self.color)
        
        let centerCirclePath = UIBezierPath()
        centerCirclePath.addArc(withCenter: CGPoint(x: rect.width/2, y: rect.height/2 + 2), radius: 8, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
        centerCirclePath.closed()
            .stroke(self.color)
    }
}
