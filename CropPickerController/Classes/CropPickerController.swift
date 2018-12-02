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
import Photos
import CropPickerView

// PHAssetCollection and PHAssetCollection together, Combine into a tuple, AssortCollection with typealias
typealias AssetCollection = (collection: PHAssetCollection, count: Int)

// Picker Type
public enum CropPickerType {
    case single
    case complex
}

public protocol CropPickerDelegate: class {
    func cropPickerBackAction(_ cropPickerController: CropPickerController)
    func cropPickerCompleteAction(_ cropPickerController: CropPickerController, images: [UIImage]?, error: Error?)
}

public class CropPickerController: UIViewController {
    // MARK: Delegate
    public weak var delegate: CropPickerDelegate?
    
    // When turned off, the observer of PHPhotoLibrary is also turned off.
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    
    // MARK: Public Property
    
    // Left Bar Button Item
    public var leftBarButtonItem: UIBarButtonItem? {
        willSet {
            self.navigationItem.leftBarButtonItem = newValue
        }
    }
    
    // Right Bar Button Item
    public var rightBarButtonItem: UIBarButtonItem? {
        willSet {
            self.navigationItem.rightBarButtonItem = newValue
        }
    }
    
    // Title Button
    public var titleButton: UIButton {
        return self._titleButton
    }
    
    // Background color of camera cell
    public var cameraBackgroundColor: UIColor {
        set {
            PictureCell.cameraBackgroundColor = newValue
        }
        get {
            return PictureCell.cameraBackgroundColor
        }
    }
    
    // Camera image color of camera cell
    public var cameraTintColor: UIColor {
        set {
            PictureCell.cameraTintColor = newValue
        }
        get {
            return PictureCell.cameraTintColor
        }
    }
    
    // Dim image color of the image cell when the image is selected
    public var pictureDimColor: UIColor {
        set {
            PictureCell.dimColor = newValue
        }
        get {
            return PictureCell.dimColor
        }
    }
    
    // The color of the background color in the selection box of the image cell.
    public var selectBoxBackgroundColor: UIColor {
        set {
            CheckBoxView.selectBackgroundColor = newValue
        }
        get {
            return CheckBoxView.selectBackgroundColor
        }
    }
    
    // The color of the layer in the Select check box of the image cell.
    public var selectBoxLayerColor: UIColor {
        set {
            CheckBoxView.layerColor = newValue
        }
        get {
            return CheckBoxView.layerColor
        }
    }
    
    // The color of the image cell's selection checkbox.
    public var selectBoxTintColor: UIColor {
        set {
            CheckBoxView.selectTintColor = newValue
        }
        get {
            return CheckBoxView.selectTintColor
        }
    }
    
    // The text color of progressView.
    public var progressTextColor: UIColor {
        get {
            return ProgressView.textColor
        }
        set {
            ProgressView.textColor = newValue
        }
    }
    
    // The color of the progressView.
    public var progressColor: UIColor {
        get {
            return ProgressView.progressColor
        }
        set {
            ProgressView.progressColor = newValue
        }
    }
    
    // The progress color of the progressView.
    public var progressTintColor: UIColor {
        get {
            return ProgressView.progressTintColor
        }
        set {
            ProgressView.progressTintColor = newValue
        }
    }
    
    // The background color of the progressView.
    public var progressBackgroundColor: UIColor {
        get {
            return ProgressView.progressBackgroundColor
        }
        set {
            ProgressView.progressBackgroundColor = newValue
        }
    }
    
    // Line color of crop view
    public var cropLineColor: UIColor? {
        set {
            self.cropPickerView.cropLineColor = newValue
        }
        get {
            return self.cropPickerView.cropLineColor
        }
    }
    
    // Color of dim view not in the crop area
    public var cropDimBackgroundColor: UIColor? {
        set {
            self.cropPickerView.dimBackgroundColor = newValue
        }
        get {
            return self.cropPickerView.dimBackgroundColor
        }
    }
    
    // Background color of scroll
    public var scrollBackgroundColor: UIColor? {
        get {
            return self.cropPickerView.scrollBackgroundColor
        }
        set {
            self.cropPickerView.scrollBackgroundColor = newValue
            self.emptyView.backgroundColor = newValue
        }
    }
    
    // Background color of image
    public var imageBackgroundColor: UIColor? {
        get {
            return self.cropPickerView.imageBackgroundColor
        }
        set {
            self.cropPickerView.imageBackgroundColor = newValue
        }
    }
    
    // Minimum zoom for scrolling
    public var scrollMinimumZoomScale: CGFloat {
        get {
            return self.cropPickerView.scrollMinimumZoomScale
        }
        set {
            self.cropPickerView.scrollMinimumZoomScale = newValue
        }
    }
    
    // Maximum zoom for scrolling
    public var scrollMaximumZoomScale: CGFloat {
        get {
            return self.cropPickerView.scrollMaximumZoomScale
        }
        set {
            self.cropPickerView.scrollMaximumZoomScale = newValue
        }
    }
    
    // Permission Gallery Denied Title
    public var permissionGalleryDeniedTitle: String? {
        get {
            return PermissionHelper.permissionGalleryDeniedTitle
        }
        set {
            PermissionHelper.permissionGalleryDeniedTitle = newValue
        }
    }
    
    // Permission Gallery Denied Message
    public var permissionGalleryDeniedMessage: String? {
        get {
            return PermissionHelper.permissionGalleryDeniedMessage
        }
        set {
            PermissionHelper.permissionGalleryDeniedMessage = newValue
        }
    }
    
    // Permission Camera Denied Title
    public var permissionCameraDeniedTitle: String? {
        get {
            return PermissionHelper.permissionCameraDeniedTitle
        }
        set {
            PermissionHelper.permissionCameraDeniedTitle = newValue
        }
    }
    
    // Permission Camera Denied Message
    public var permissionCameraDeniedMessage: String? {
        get {
            return PermissionHelper.permissionCameraDeniedMessage
        }
        set {
            PermissionHelper.permissionCameraDeniedMessage = newValue
        }
    }
    
    // Permission Action Cancel Title
    public var permissionActionCancelTitle: String? {
        get {
            return PermissionHelper.permissionActionCancelTitle
        }
        set {
            PermissionHelper.permissionActionCancelTitle = newValue
        }
    }
    
    // Permission Action Move Title
    public var permissionActionMoveTitle: String? {
        get {
            return PermissionHelper.permissionActionMoveTitle
        }
        set {
            PermissionHelper.permissionActionMoveTitle = newValue
        }
    }
    
    
    // MARK: Private Property
    
    // Picker Type
    private var cropPickerType: CropPickerType
    
    // Is Camera
    private var isCamera: Bool
    
    private let cropPickerView = CropPickerView()
    
    private lazy var progressView: ProgressView = {
        let progressView = ProgressView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        self.view.insertSubview(progressView, aboveSubview: self.cropPickerView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        self.view.centerXConstraint(item: self.cropPickerView, subView: progressView)
        self.view.centerYConstraint(item: self.cropPickerView, subView: progressView)
        progressView.sizeConstraint(constant: 50)
        return progressView
    }()
    
    private lazy var emptyView: UIView = {
        let view = UIView()
        self.view.insertSubview(view, belowSubview: self.cropPickerView)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.leadingConstraint(subView: view)
        self.view.trailingConstraint(subView: view)
        self.view.addConstraint(NSLayoutConstraint(item: self.cropPickerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0))
        view.heightConstraint(constant: 5)
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/3)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        self.view.insertSubview(collectionView, aboveSubview: self.cropPickerView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.leadingConstraint(subView: collectionView)
        self.view.trailingConstraint(subView: collectionView)
        self.view.bottomConstraint(subView: collectionView)
        self.view.addConstraint(NSLayoutConstraint(item: self.emptyView, attribute: .bottom, relatedBy: .equal, toItem: collectionView, attribute: .top, multiplier: 1, constant: 0))
        return collectionView
    }()
    
    private lazy var _titleButton: UIButton = {
        let button = TitleButton(type: UIButton.ButtonType.system)
        button.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.navigationController?.navigationBar.frame.height ?? 0)
        button.setTitle(nil, for: .normal)
        button.setImage(nil, for: .normal)
        if #available(iOS 9.0, *) {
            button.semanticContentAttribute = .forceRightToLeft
        }
        button.addTarget(self, action: #selector(self.albumTap(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        self.view.insertSubview(tableView, aboveSubview: self.scrollButton)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let tableViewHeightConstraint = NSLayoutConstraint(item: tableView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 0)
        tableViewHeightConstraint.priority = UILayoutPriority(950)
        tableView.addConstraint(tableViewHeightConstraint)
        self.tableViewHeightConstraint = tableViewHeightConstraint
        self.view.leadingConstraint(subView: tableView)
        self.view.trailingConstraint(subView: tableView)
        self.view.bottomConstraint(subView: tableView, relatedBy: .greaterThanOrEqual)
        self.view.topConstraint(item: self.cropPickerView, subView: tableView)
        return tableView
    }()
    
    private var tableViewHeightConstraint: NSLayoutConstraint?
    
    private lazy var scrollButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
        self.view.insertSubview(button, aboveSubview: self.collectionView)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.trailingConstraint(subView: button, constant: 20)
        var bottomSize: CGFloat = 20
        if #available(iOS 11.0, *) {
            bottomSize += (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0)
        }
        self.view.bottomConstraint(subView: button, constant: bottomSize)
        button.sizeConstraint(constant: 48)
        button.addTarget(self, action: #selector(self.scrollBottomTap(_:)), for: .touchUpInside)
        return button
    }()
    
    private var topConstant: CGFloat {
        return (self.navigationController?.navigationBar.frame.height ?? 0) + UIApplication.shared.statusBarFrame.height
    }
    
    private lazy var imageRequestOptions: PHImageRequestOptions = {
        let imageRequestOptions = PHImageRequestOptions()
        imageRequestOptions.isSynchronous = true
        imageRequestOptions.resizeMode = .fast
        imageRequestOptions.isNetworkAccessAllowed = true
        imageRequestOptions.deliveryMode = .highQualityFormat
        return imageRequestOptions
    }()
    
    private var hidesBackButton: Bool?
    
    // ImageAsset Gallery Array
    private var galleryArray = [ImageAsset]()
    
    // ImageAsset Camera Array
    private var cameraArray = [ImageAsset]()
    
    // ImageAsset Array
    private var array = [ImageAsset]()
    
    private var lastIndex: Int? {
        if self.array.isEmpty { return nil }
        let array = self.array
        if self.isCamera && array.count > 1 {
            return array.count - 2
        } else if !self.isCamera && array.count > 0 {
            return array.count - 1
        }
        return nil
    }
    
    // AssetCollection Array
    private var assetCollectionArray = [AssetCollection]()
    private var assetCollectionIndex = 0
    
    private var currentIndexPath = IndexPath(item: -1, section: 0)
    
    
    // MARK: Init
    
    public init(_ type: CropPickerType, isCamera: Bool = true) {
        self.cropPickerType = type
        self.isCamera = isCamera
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.cropPickerType = .single
        self.isCamera = true
        super.init(coder: aDecoder)
    }
    
    // MARK: Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        PHPhotoLibrary.shared().register(self)
        
        self.navigationItem.titleView = self.titleButton
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.cropPickerView)
        self.cropPickerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.leadingConstraint(subView: self.cropPickerView)
        self.view.trailingConstraint(subView: self.cropPickerView)
        self.view.topConstraint(subView: self.cropPickerView, constant: -self.topConstant)
        self.view.heightConstraint(subView: self.cropPickerView, multiplier: 667 / 260)
        if self.cropPickerType == .complex {
            self.cropPickerView.isCrop = false
        }
        
        self.emptyView.backgroundColor = .black
        
        self.collectionView.backgroundColor = .white
        self.collectionView.register(PictureCell.self, forCellWithReuseIdentifier: PictureCell.identifier)
        self.collectionView.bounces = false
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.scrollButton.setImage(ArrowScrollBottomView.imageView(.black), for: .normal)
        self.scrollButton.backgroundColor = .white
        self.scrollButton.layer.cornerRadius = self.scrollButton.frame.width/2
        self.scrollButton.layer.borderWidth = 0.1
        self.scrollButton.layer.borderColor = UIColor(white: 0, alpha: 0.5).cgColor
        self.scrollButton.alpha = 0
        
        self.progressView.isHidden = true
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        self.tableView.rowHeight = 56
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        if self.leftBarButtonItem == nil {
            self.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.backTap(_:)))
        }
        
        if self.rightBarButtonItem == nil {
            self.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.cropTap(_:)))
        }
        
        PermissionHelper.galleryPermission { (alertController) in
            guard let alertController = alertController else {
                self.assetFetchData()
                return
            }
            self.present(alertController, animated: true)
        }
    }
    
    // MARK: Public Method
    
    // Back Tap
    @objc public func backTap(_ sender: UIBarButtonItem) {
        self.delegate?.cropPickerBackAction(self)
    }
    
    // Crop Tap
    @objc public func cropTap(_ sender: UIBarButtonItem) {
        if self.cropPickerType == .single {
            self.cropPickerView.crop { (error, image) in
                if let image = image {
                    self.delegate?.cropPickerCompleteAction(self, images: [image], error: error)
                } else {
                    self.delegate?.cropPickerCompleteAction(self, images: nil, error: error)
                }
            }
        } else {
            let imageArray = self.array.filter({ $0.isCheck }).sorted(by: { $0.number < $1.number }).compactMap({ $0.image })
            self.delegate?.cropPickerCompleteAction(self, images: imageArray, error: nil)
        }
    }
    
    // MARK: Private Method
    
    private func makeAsset() {
        var array = [ImageAsset]()
        array.append(contentsOf: self.galleryArray)
        array.append(contentsOf: self.cameraArray)
        if self.isCamera {
            array.append(ImageAsset())
        }
        self.array = array
    }
    
    // Album List Data Load
    private func assetFetchData() {
        DispatchQueue.global().async {
            var assetCollectionArray = [AssetCollection]()
            PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.smartAlbum, subtype: PHAssetCollectionSubtype.any, options: PHFetchOptions()).enumerateObjects { (collection, _, _) in
                let count = PHAsset.fetchAssets(in: collection, options: nil).count
                if count != 0 {
                    if collection.assetCollectionSubtype == PHAssetCollectionSubtype.smartAlbumUserLibrary {
                        assetCollectionArray.insert((collection, count), at: 0)
                    } else {
                        assetCollectionArray.append((collection, count))
                    }
                }
            }
            self.assetCollectionIndex = 0
            self.assetCollectionArray = assetCollectionArray
            self.albumFetchData()
            
            DispatchQueue.main.async {
                self.makeTitle()
                self.tableView.reloadData()
                self.hideAlbum()
            }
        }
    }
    
    // Picture List Load
    private func albumFetchData() {
        var array = [ImageAsset]()
        PHAsset.fetchAssets(in: self.assetCollectionArray[self.assetCollectionIndex].0, options: PHFetchOptions()).enumerateObjects({ (asset, _, _) in
            array.append(ImageAsset(asset))
        })
        DispatchQueue.main.async {
            self.galleryArray = array
            self.makeAsset()
            if let lastIndex = self.lastIndex {
                self.currentIndexPath = IndexPath(item: lastIndex, section: 0)
            }
            self.collectionView.reloadData()
            
            if let lastIndex = self.lastIndex {
                self.collectionView.scrollToItem(at: IndexPath(item: lastIndex, section: 0), at: UICollectionView.ScrollPosition.bottom, animated: false)
                let item = self.array[lastIndex]
                if let image = item.image {
                    DispatchQueue.main.async {
                        self.cropPickerView.image = image
                        self.scrollButton.alpha = 0
                    }
                } else if let asset = item.asset {
                    let size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    PHCachingImageManager().requestImage(for: asset, targetSize: size, contentMode: .aspectFit, options: self.imageRequestOptions, resultHandler: { (image, _) in
                        DispatchQueue.main.async {
                            self.cropPickerView.image = image
                            self.scrollButton.alpha = 0
                        }
                    })
                }
            } else {
                self.cropPickerView.image = nil
            }
        }
    }
    
    // Title Button
    private func makeTitle() {
        guard let title = self.assetCollectionArray[self.assetCollectionIndex].collection.localizedTitle else { return }
        self.titleButton.setTitle(title, for: .normal)
        self.titleButton.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.navigationController?.navigationBar.frame.height ?? 0)
        self.titleButton.sizeToFit()
    }
    
    // Scroll To Bottom
    @objc private func scrollBottomTap(_ sender: UIButton) {
        if let lastIndex = self.lastIndex {
            self.collectionView.scrollToItem(at: IndexPath(item: lastIndex, section: 0), at: UICollectionView.ScrollPosition.bottom, animated: true)
        }
    }
    
    // Title Button Tap
    @objc private func albumTap(_ sender: UIButton) {
        guard let tableViewHeightConstraint = self.tableViewHeightConstraint else { return }
        if tableViewHeightConstraint.constant == 0 {
            self.showAlbum()
        } else {
            self.hideAlbum()
        }
    }
    
    // Show Album List UITableView
    private func showAlbum() {
        self.tableViewHeightConstraint?.constant = self.view.bounds.height
        
        self.leftBarButtonItem = self.navigationItem.leftBarButtonItem
        self.rightBarButtonItem = self.navigationItem.rightBarButtonItem
        self.hidesBackButton = self.navigationItem.hidesBackButton
        
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            (self.navigationItem.titleView as? UIButton)?.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(180).degreesToRadians)
        }
        
        if !self.assetCollectionArray.isEmpty {
            self.tableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
        }
    }
    
    // Hide Album List UITableView
    private func hideAlbum() {
        self.tableViewHeightConstraint?.constant = 0
        
        self.navigationItem.leftBarButtonItem = self.leftBarButtonItem
        self.navigationItem.rightBarButtonItem = self.rightBarButtonItem
        if let hidesBackButton = self.hidesBackButton {
            self.navigationItem.hidesBackButton = hidesBackButton
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            (self.navigationItem.titleView as? UIButton)?.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(0).degreesToRadians)
        }
    }
    
}

// MARK: PHPhotoLibraryChangeObserver
extension CropPickerController: PHPhotoLibraryChangeObserver {
    public func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard !self.assetCollectionArray.isEmpty else { return }
        DispatchQueue.global().async {
            var array = [ImageAsset]()
            PHAsset.fetchAssets(in: self.assetCollectionArray[self.assetCollectionIndex].0, options: PHFetchOptions()).enumerateObjects({ (asset, _, _) in
                array.append(ImageAsset(asset))
            })
            if array.count != self.galleryArray.count {
                DispatchQueue.main.async {
                    self.galleryArray = array
                    self.makeAsset()
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

// MARK: UICollectionViewDelegate
extension CropPickerController: UICollectionViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Scroll To Bottom Button Alpha
        if scrollView == self.collectionView {
            let deltaOffsetY = (scrollView.contentSize.height - scrollView.frame.size.height) - scrollView.contentOffset.y
            if deltaOffsetY > UIScreen.main.bounds.height {
                UIView.animate(withDuration: 0.2) {
                    self.scrollButton.alpha = 1
                }
            } else if deltaOffsetY < 100 {
                UIView.animate(withDuration: 0.2) {
                    self.scrollButton.alpha = 0
                }
            }
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.array[indexPath.row]
        
        // Camera
        if item.type == .camera {
            PermissionHelper.cameraPermission({ (alertController) in
                guard let alertController = alertController else {
                    let pickerController = UIImagePickerController()
                    pickerController.delegate = self
                    pickerController.sourceType = .camera
                    pickerController.allowsEditing = false
                    DispatchQueue.main.async {
                        self.present(pickerController, animated: true)
                    }
                    return
                }
                // Open UIImagePickerController
                DispatchQueue.main.async {
                    self.present(alertController, animated: true)
                }
            })
        } else {
            if self.cropPickerType == .single { // Single
                for (index, _) in self.array.enumerated() {
                    self.array[index].isCheck = false
                }
                self.array[indexPath.row].isCheck = true
                self.currentIndexPath = indexPath
            } else { // Complex
                func checkAdd() {
                    self.array[indexPath.row].number = self.array.filter({ $0.isCheck }).count + 1
                    self.array[indexPath.row].isCheck = true
                    if self.array[indexPath.row].type == .image {
                        if let index = self.galleryArray.enumerated().filter({ $0.element == self.array[indexPath.row] }).first.map({ $0.offset }) {
                            self.galleryArray[index].isCheck = true
                            self.galleryArray[index].number = self.array[indexPath.row].number
                        }
                    } else {
                        if let index = self.cameraArray.enumerated().filter({ $0.element == self.array[indexPath.row] }).first.map({ $0.offset }) {
                            self.cameraArray[index].isCheck = true
                            self.cameraArray[index].number = self.array[indexPath.row].number
                        }
                    }
                }
                if self.currentIndexPath == indexPath {
                    if self.array[indexPath.row].isCheck {
                        let number = self.array[indexPath.row].number
                        self.array[indexPath.row].checkCancel()
                        
                        if self.array[indexPath.row].type == .image {
                            if let index = self.galleryArray.enumerated().filter({ $0.element == self.array[indexPath.row] }).first.map({ $0.offset }) {
                                self.galleryArray[index].checkCancel()
                            }
                        } else {
                            if let index = self.cameraArray.enumerated().filter({ $0.element == self.array[indexPath.row] }).first.map({ $0.offset }) {
                                self.cameraArray[index].checkCancel()
                            }
                        }
                        
                        for (index, element) in self.array.enumerated() {
                            if element.isCheck && element.number > number {
                                self.array[index].number -= 1
                            }
                        }
                        for (index, element) in self.galleryArray.enumerated() {
                            if element.isCheck && element.number > number {
                                self.galleryArray[index].number -= 1
                            }
                        }
                        for (index, element) in self.cameraArray.enumerated() {
                            if element.isCheck && element.number > number {
                                self.cameraArray[index].number -= 1
                            }
                        }
                    } else {
                        checkAdd()
                    }
                } else if !self.array[indexPath.row].isCheck {
                    checkAdd()
                }
                self.currentIndexPath = indexPath
            }
            self.collectionView.reloadData()
            
            if item.type == .cameraImage { // CameraImage
                self.cropPickerView.image = item.image
            } else if item.type == .image { // AlbumImage
                guard let asset = self.array[indexPath.row].asset else { return }
                let imageManager = PHCachingImageManager()
                let imageRequestOptions = PHImageRequestOptions()
                imageRequestOptions.isSynchronous = true
                imageRequestOptions.deliveryMode = .highQualityFormat
                imageRequestOptions.isNetworkAccessAllowed = true
                imageRequestOptions.progressHandler = { (progress, error, stop, info) in
                    DispatchQueue.main.async {
                        self.progressView.isHidden = false
                        self.progressView.setProgress(CGFloat(progress))
                    }
                }
                self.cropPickerView.image = nil
                DispatchQueue.global().async {
                    imageManager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: imageRequestOptions, resultHandler: { (image, _) in
                        DispatchQueue.main.async {
                            self.progressView.isHidden = true
                            self.cropPickerView.image = image
                        }
                    })
                }
            }
        }
        
    }
}

// MARK: UICollectionViewDataSource
extension CropPickerController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.array.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PictureCell.identifier, for: indexPath) as? PictureCell else { fatalError() }
        let row = indexPath.row
        let item = self.array[row]
        cell.setEntity(self.cropPickerType, item: item, isSelected: indexPath == self.currentIndexPath)
        if item.type == .image, let asset = item.asset {
            let size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
            PHCachingImageManager().requestImage(for: asset, targetSize: size, contentMode: .aspectFit, options: self.imageRequestOptions, resultHandler: { (image, _) in
                self.array[row].image = image
                cell.setEntity(self.array[row])
            })
        }
        return cell
    }
}

// MARK: UITableViewDelegate
extension CropPickerController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.assetCollectionIndex = indexPath.row
        self.makeTitle()
        self.hideAlbum()
        
        for (index, _) in self.cameraArray.enumerated() {
            self.cameraArray[index].checkCancel()
        }
        
        DispatchQueue.global().async {
            self.albumFetchData()
        }
    }
}

// MARK: UITableViewDataSource
extension CropPickerController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.assetCollectionArray.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let item = self.assetCollectionArray[indexPath.row]
        cell.textLabel?.text = item.0.localizedTitle?.appending(" (\(item.count))")
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

// MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension CropPickerController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)?.fixOrientation else { return }
        picker.dismiss(animated: true, completion: nil)
        self.cameraArray.append(ImageAsset(image))
        self.makeAsset()
        self.cropPickerView.image = image
        self.collectionView.reloadData()
    }
}
