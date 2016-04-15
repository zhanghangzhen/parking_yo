//
//  Color+Extension.swift
//  parking_yo
//
//  Created by zhanghangzhen on 16/4/7.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

import UIKit

/// 对UIColor的扩展
extension UIColor {
    class func colorWithCustom(r:CGFloat,g:CGFloat,b:CGFloat)->UIColor{
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
     class func randomColor()->UIColor {
        let r = CGFloat(arc4random_uniform(256))
        let g = CGFloat(arc4random_uniform(256))
        let b = CGFloat(arc4random_uniform(256))
        return UIColor.colorWithCustom(r, g: g, b: b)
     }
 }

/// 对UIView的扩展
extension UIView {
    /// X值
    var x: CGFloat {
        return self.frame.origin.x
    }
    /// Y值
    var y: CGFloat {
        return self.frame.origin.y
    }
    /// 宽度
    var width: CGFloat {
        return self.frame.size.width
    }
    ///高度
    var height: CGFloat {
        return self.frame.size.height
    }
    var size: CGSize {
        return self.frame.size
    }
    var point: CGPoint {
        return self.frame.origin
    }
}


extension UIDevice {
    
    class func currentDeviceScreenMeasurement() -> CGFloat {
        var deviceScree: CGFloat = 3.5
        
        if ((568 == ScreenHeight && 320 == ScreenWidth) || (1136 == ScreenHeight && 640 == ScreenWidth)) {
            deviceScree = 4.0;
        } else if ((667 == ScreenHeight && 375 == ScreenWidth) || (1334 == ScreenHeight && 750 == ScreenWidth)) {
            deviceScree = 4.7;
        } else if ((736 == ScreenHeight && 414 == ScreenWidth) || (2208 == ScreenHeight && 1242 == ScreenWidth)) {
            deviceScree = 5.5;
        }
        
        return deviceScree
    }
}
extension UIImage {
    
    class func imageWithColor(color: UIColor, size: CGSize, alpha: CGFloat) -> UIImage {
        let rect = CGRectMake(0, 0, size.width, size.height)
        
        UIGraphicsBeginImageContext(rect.size)
        let ref = UIGraphicsGetCurrentContext()
        CGContextSetAlpha(ref, alpha)
        CGContextSetFillColorWithColor(ref, color.CGColor)
        CGContextFillRect(ref, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    class func createImageFromView(view: UIView) -> UIImage {
        UIGraphicsBeginImageContext(view.bounds.size);
        
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        return image
    }
    
    func imageClipOvalImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        let ctx = UIGraphicsGetCurrentContext()
        let rect = CGRectMake(0, 0, self.size.width, self.size.height)
        CGContextAddEllipseInRect(ctx, rect)
        
        CGContextClip(ctx)
        self.drawInRect(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}