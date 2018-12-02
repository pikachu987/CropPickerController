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

class PermissionHelper: NSObject {
    private override init() { }
    
    // Gallery Permission
    static func galleryPermission(_ handler: @escaping ((UIAlertController?) -> Void)) {
        DispatchQueue.main.async {
            if PHPhotoLibrary.authorizationStatus() == .authorized {
                handler(nil)
            } else if PHPhotoLibrary.authorizationStatus() == .denied {
                handler(self.deniedAlertController("", message: ""))
            } else {
                PHPhotoLibrary.requestAuthorization() { (status) in
                    switch status {
                    case .authorized:
                        handler(nil)
                        break
                    default:
                        handler(self.deniedAlertController("", message: ""))
                    }
                }
            }
        }
    }
    
    
    // Camera Permission
    static func cameraPermission(_ handler: @escaping ((UIAlertController?) -> Void)) {
        DispatchQueue.main.async {
            if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .authorized {
                handler(nil)
            } else if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .denied {
                handler(self.deniedAlertController("", message: ""))
            } else {
                AVCaptureDevice.requestAccess(for: AVMediaType.video) { (isAccess) in
                    if isAccess{
                        handler(nil)
                    } else {
                        handler(self.deniedAlertController("", message: ""))
                    }
                }
            }
        }
    }
    
    // Denied
    private static func deniedAlertController(_ title: String, message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "", style: .default, handler: { (_) in
            self.openSetting()
        }))
        return alertController
    }
    
    // Setting
    private static func openSetting() {
        guard let bundleIdentifier = Bundle.main.bundleIdentifier else { return }
        guard let url = URL(string: "\(UIApplication.openSettingsURLString)\(bundleIdentifier)") else { return }
        if !UIApplication.shared.canOpenURL(url) { return }
        
        if #available(iOS 8.0, *) {
            UIApplication.shared.openURL(url)
        } else {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}
