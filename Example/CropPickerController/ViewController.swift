//
//  ViewController.swift
//  CropPickerController
//
//  Created by pikachu987 on 11/28/2018.
//  Copyright (c) 2018 pikachu987. All rights reserved.
//

import UIKit
import CropPickerController

class TitleCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
}

class ImageCell: UITableViewCell {
    @IBOutlet weak var cropImageView: UIImageView!
}

enum CropType: String {
    case presentSignle = "Single present"
    case presentComplex = "Complex present"
    case pushSignle = "Single push"
    case pushComplex = "Complex push"
    case noneCameraSingle = "None Camera Single present"
    case noneCameraComplex = "None Camera Complex present"
    
    static let array = [
        CropType.presentSignle,
        CropType.presentComplex,
        CropType.pushSignle,
        CropType.pushComplex,
        CropType.noneCameraSingle,
        CropType.noneCameraComplex,
        ]
}

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var array = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.rowHeight = 150
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeCropPickerController(_ type: CropPickerType, isCamera: Bool) -> CropPickerController {
        let cropPickerController = CropPickerController(type, isCamera: isCamera)
        cropPickerController.delegate = self
        
//        cropPickerController.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: cropPickerController, action: #selector(cropPickerController.backTap(_:)))
//        cropPickerController.rightBarButtonItem = UIBarButtonItem(title: "Crop", style: .done, target: cropPickerController, action: #selector(cropPickerController.cropTap(_:)))
//
//        cropPickerController.leftBarButtonItem?.tintColor = .black
//        cropPickerController.rightBarButtonItem?.tintColor = .black
//        cropPickerController.titleButton.setTitleColor(.black, for: .normal)
//
//        cropPickerController.cameraTintColor = .red
//        cropPickerController.cameraBackgroundColor = UIColor(white: 0.2, alpha: 1)
//
//        cropPickerController.pictureDimColor = UIColor(red: 242/255, green: 121/255, blue: 141/255, alpha: 0.5)
//
//        cropPickerController.selectBoxTintColor = .black
//        cropPickerController.selectBoxLayerColor = .gray
//        cropPickerController.selectBoxBackgroundColor = .gray
//
//        cropPickerController.permissionGalleryDeniedTitle = "Denied"
//        cropPickerController.permissionGalleryDeniedMessage = "Denied Gallery"
//        cropPickerController.permissionCameraDeniedTitle = "Denied"
//        cropPickerController.permissionCameraDeniedMessage = "Denied Camera"
//        cropPickerController.permissionActionMoveTitle = "Move~"
//        cropPickerController.permissionActionCancelTitle = "Cancel!"
//
//        cropPickerController.progressTextColor = .black
//        cropPickerController.progressColor = .red
//        cropPickerController.progressTintColor = .blue
//        cropPickerController.progressBackgroundColor = .white
//
//        cropPickerController.cropLineColor = .blue
//        cropPickerController.imageBackgroundColor = .white
//        cropPickerController.scrollBackgroundColor = .white
//        cropPickerController.cropDimBackgroundColor = UIColor(white: 0, alpha: 0.9)
//        cropPickerController.scrollMinimumZoomScale = 0.1
//        cropPickerController.scrollMaximumZoomScale = 12

        return cropPickerController
    }
}

// MARK: CropPickerDelegate
extension ViewController: CropPickerDelegate {
    func cropPickerBackAction(_ cropPickerController: CropPickerController) {
        if (cropPickerController.navigationController?.viewControllers.first as? CropPickerController) == nil {
            cropPickerController.navigationController?.popViewController(animated: true)
        } else {
            cropPickerController.dismiss(animated: true, completion: nil)
        }
    }
    func cropPickerCompleteAction(_ cropPickerController: CropPickerController, images: [UIImage]?, error: Error?) {
        if let error = error as NSError? {
            let alertController = UIAlertController(title: "Error", message: error.domain, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            cropPickerController.present(alertController, animated: true, completion: nil)
            return
        }
        
        if (cropPickerController.navigationController?.viewControllers.first as? CropPickerController) == nil {
            cropPickerController.navigationController?.popViewController(animated: true)
        } else {
            cropPickerController.dismiss(animated: true, completion: nil)
        }
        
        if let images = images {
            self.array = images
            self.tableView.reloadData()
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = CropType.array[indexPath.row].rawValue
        let size = text.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)])
        return CGSize(width: size.width + 20, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CropType.array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TitleCell", for: indexPath) as! TitleCell
        cell.titleLabel.text = CropType.array[indexPath.row].rawValue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let element = CropType.array[indexPath.row]
        if element == .presentSignle {
            let cropPickerController = self.makeCropPickerController(.single, isCamera: true)
            let navigationController = UINavigationController(rootViewController: cropPickerController)
            self.present(navigationController, animated: true, completion: nil)
        }
        else if element == .presentComplex {
            let cropPickerController = self.makeCropPickerController(.complex, isCamera: true)
            let navigationController = UINavigationController(rootViewController: cropPickerController)
            self.present(navigationController, animated: true, completion: nil)
        }
        else if element == .pushSignle {
            let cropPickerController = self.makeCropPickerController(.single, isCamera: true)
            self.navigationController?.pushViewController(cropPickerController, animated: true)
        }
        else if element == .pushComplex {
            let cropPickerController = self.makeCropPickerController(.complex, isCamera: true)
            self.navigationController?.pushViewController(cropPickerController, animated: true)
        }
        else if element == .noneCameraSingle {
            let cropPickerController = self.makeCropPickerController(.single, isCamera: false)
            let navigationController = UINavigationController(rootViewController: cropPickerController)
            self.present(navigationController, animated: true, completion: nil)
        }
        else if element == .noneCameraComplex {
            let cropPickerController = self.makeCropPickerController(.complex, isCamera: false)
            let navigationController = UINavigationController(rootViewController: cropPickerController)
            self.present(navigationController, animated: true, completion: nil)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.cropImageView.image = self.array[indexPath.row]
        return cell
    }
}
