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

// Check Box Or Check Number View
class CheckBoxView: UIView {
    static var selectBackgroundColor = UIColor(red: 53/255, green: 150/255, blue: 240/255, alpha: 1)
    static var layerColor = UIColor.white
    static var selectTintColor = UIColor.white
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.leadingConstraint(subView: label, constant: -3)
        self.trailingConstraint(subView: label, constant: 3)
        self.centerYConstraint(subView: label)
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.leadingConstraint(subView: imageView, constant: -3)
        self.trailingConstraint(subView: imageView, constant: 3)
        self.topConstraint(subView: imageView, constant: 3)
        self.bottomConstraint(subView: imageView, constant: 3)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = CheckBoxView.layerColor.cgColor
        self.layer.cornerRadius = 12
        self.numberLabel.textColor = CheckBoxView.selectTintColor
        self.numberLabel.font = UIFont.systemFont(ofSize: 13)
        self.numberLabel.textAlignment = .center
        self.numberLabel.adjustsFontSizeToFitWidth = true
        self.numberLabel.minimumScaleFactor = 0.3
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setEntity(_ number: Int = 0) {
        self.imageView.isHidden = true
        if number == 0 {
            self.backgroundColor = .clear
            self.numberLabel.isHidden = true
        } else {
            self.backgroundColor = CheckBoxView.selectBackgroundColor
            self.numberLabel.isHidden = false
            self.numberLabel.text = "\(number)"
        }
    }
    
    func setEntity(_ isSelected: Bool) {
        self.backgroundColor = isSelected ? CheckBoxView.selectBackgroundColor : .clear
        self.numberLabel.isHidden = true
        self.imageView.isHidden = false
        self.imageView.image = isSelected ? CheckView.image(CheckBoxView.selectTintColor) : nil
    }
}
