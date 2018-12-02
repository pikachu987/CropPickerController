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

// Make Check Image
class CheckView: UIView {
    private static var staticImage: UIImage?
    
    static func image(_ color: UIColor) -> UIImage? {
        if CheckView.staticImage == nil {
            let image = CheckView.imageView(color)
            CheckView.staticImage = image
            return image
        } else {
            return CheckView.staticImage
        }
    }
    
    static func imageView(_ color: UIColor) -> UIImage? {
        let view = CheckView(color)
        view.setNeedsDisplay()
        view.isOpaque = false
        view.tintColor = color
        return view.imageWithView?.withRenderingMode(.alwaysOriginal)
    }
    
    private var color: UIColor
    
    init(_ color: UIColor) {
        self.color = color
        super.init(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.color = .black
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        self.backgroundColor = .clear
        let path = UIBezierPath()
            .move(6, 15)
            .line(12, 19)
            .line(20, 11)
            .line(12, 18)
            .line(6, 15)
        path.closed()
            .strokeFill(self.color, lineWidth: 1.5)
    }
}
