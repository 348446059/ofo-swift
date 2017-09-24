//
//  UIViewHelper.swift
//  Samoff
//
//  Created by libo on 2017/9/17.
//  Copyright © 2017年 libo. All rights reserved.
//

import Foundation

extension UIView {
   @IBInspectable var borderwidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    
   @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor:self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
  @IBInspectable  var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0
        }
    }
}

@IBDesignable class MyPreviewLabel: UILabel {
    
}

@IBDesignable class MyPreviewButtom: UIButton {
    
}


import AVFoundation

func turnTorch() {
    
    guard let device  = AVCaptureDevice.default(for: AVMediaType.video) else {
        return
    }
    
    if device.hasTorch && device.isTorchAvailable {
        try?device.lockForConfiguration()
        
        
        if device.torchMode == .off{
            device.torchMode = .on
        }else{
            device.torchMode = .off
        }
        device.unlockForConfiguration()
    }
}
