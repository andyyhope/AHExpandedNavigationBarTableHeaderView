//
//  UIImage+Snapshot.swift
//  HorseProfile
//
//  Created by Andyy Hope on 9/03/2016.
//  Copyright © 2016 Punters. All rights reserved.
//

import UIKit

extension UIImage {
    static func snapshotFromView(view: UIView, frame: CGRect) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(view.frame.size, view.opaque, 0.0)
        
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        
        let viewImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        let imageRef = CGImageCreateWithImageInRect(viewImage.CGImage, frame)
        let image = UIImage(CGImage: imageRef!)
        
        return image
    }
}
