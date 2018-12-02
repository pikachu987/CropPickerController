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

// PictureCell
class PictureCell: UICollectionViewCell {
    static let identifier = "PictureCell"
    static var cameraBackgroundColor = UIColor(white: 212/255, alpha: 1)
    static var cameraTintColor = UIColor.white
    static var dimColor = UIColor(white: 0, alpha: 0.5)
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        self.contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.edgesConstraint(subView: imageView)
        return imageView
    }()
    
    private lazy var dimView: UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.edgesConstraint(subView: view)
        return view
    }()
    
    private lazy var checkBoxView: CheckBoxView = {
        let view = CheckBoxView()
        self.contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.topConstraint(subView: view, constant: -10)
        self.contentView.trailingConstraint(subView: view, constant: 10)
        view.sizeConstraint(constant: 24)
        return view
    }()
    
    private lazy var cameraView: CameraView = {
        let view = CameraView(PictureCell.cameraTintColor)
        view.backgroundColor = PictureCell.cameraBackgroundColor
        self.contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.centerXConstraint(subView: view)
        self.contentView.centerYConstraint(subView: view)
        view.sizeConstraint(constant: 40)
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageView.image = nil
        self.dimView.backgroundColor = .clear
        self.checkBoxView.isHidden = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.clipsToBounds = true
        self.imageView.contentMode = .scaleAspectFill
        self.dimView.backgroundColor = .clear
        self.cameraView.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setEntity(_ cropPickerType: CropPickerType, item: ImageAsset, isSelected: Bool) {
        if item.type == .camera {
            self.cameraView.isHidden = false
            self.dimView.backgroundColor = PictureCell.cameraBackgroundColor
        } else {
            self.cameraView.isHidden = true
            self.imageView.image = item.image
            self.dimView.backgroundColor = isSelected ? PictureCell.dimColor : .clear
            self.checkBoxView.isHidden = false
            if cropPickerType == .single {
                self.checkBoxView.setEntity(isSelected)
            } else {
                self.checkBoxView.setEntity(item.number)
            }
        }
    }
    
    func setEntity(_ item: ImageAsset) {
        self.imageView.image = item.image
    }
}
