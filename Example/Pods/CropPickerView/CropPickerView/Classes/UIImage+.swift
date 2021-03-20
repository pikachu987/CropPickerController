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

extension UIImage {
    var fixOrientation: UIImage? {
        if self.imageOrientation == .up { return self }
        var transform = CGAffineTransform.identity

        if self.imageOrientation == .down || self.imageOrientation == .downMirrored {
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
        }

        if self.imageOrientation == .left || self.imageOrientation == .leftMirrored {
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi / 2.0))
        }

        if self.imageOrientation == .right || self.imageOrientation == .rightMirrored {
            transform = transform.translatedBy(x: 0, y: self.size.height)
            transform = transform.rotated(by: CGFloat(-Double.pi / 2.0))
        }

        if self.imageOrientation == .upMirrored || self.imageOrientation == .downMirrored {
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        }

        if self.imageOrientation == .leftMirrored || self.imageOrientation == .rightMirrored {
            transform = transform.translatedBy(x: self.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        }

        guard let cgImage = self.cgImage,
            let colorSpace = cgImage.colorSpace else { return nil }

        guard let ctx = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height),
                                  bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0,
                                  space: colorSpace,
                                  bitmapInfo: cgImage.bitmapInfo.rawValue) else { return nil }

        ctx.concatenate(transform)

        if self.imageOrientation == .left ||
            self.imageOrientation == .leftMirrored ||
            self.imageOrientation == .right ||
            self.imageOrientation == .rightMirrored {
            ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: self.size.height, height: self.size.width))
        } else {
            ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        }
        guard let makeImage = ctx.makeImage() else { return nil }
        return UIImage(cgImage: makeImage)
    }

    func crop(_ rect: CGRect, radius: CGFloat, radiusScale: CGFloat, scale: CGFloat = 1) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: rect.size.width / scale, height: rect.size.height / scale), true, 0.0)
        self.draw(at: CGPoint(x: -rect.origin.x / scale, y: -rect.origin.y / scale))
        let croppedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if radius == 0 {
            return croppedImage
        } else {
            guard let image = croppedImage else { return nil }
            let imageView = UIImageView(image: image)
            let layer = imageView.layer
            layer.masksToBounds = true
            layer.cornerRadius = radius * radiusScale
            UIGraphicsBeginImageContext(imageView.bounds.size)
            if let currentContext = UIGraphicsGetCurrentContext() {
                layer.render(in: currentContext)
            }
            let croppedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return croppedImage
        }
    }
}
