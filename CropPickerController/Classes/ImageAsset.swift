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

import Foundation
import Photos

// Image Asset
struct ImageAsset {
    // Camera Type, Image Type, Camera Image Type
    enum ImageAssetType {
        case camera, image, cameraImage
    }
    
    var type = ImageAssetType.image
    var asset: PHAsset?
    var image: UIImage?
    var isCheck = false
    var number = 0
    
    init() {
        self.type = .camera
    }
    
    init(_ image: UIImage) {
        self.type = .cameraImage
        self.image = image
    }
    
    init(_ asset: PHAsset) {
        self.asset = asset
        self.type = .image
    }
    
    mutating func checkCancel() {
        self.isCheck = false
        self.number = 0
    }
    
    static func ==(lhs: ImageAsset, rhs: ImageAsset) -> Bool {
        if lhs.type == rhs.type {
            if lhs.type == .image {
                return lhs.asset == rhs.asset
            } else if lhs.type == .cameraImage {
                return lhs.image == rhs.image
            } else { return true }
        } else { return false }
    }
}
