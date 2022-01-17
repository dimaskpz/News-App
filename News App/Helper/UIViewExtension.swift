//
//  UIViewExtension.swift
//  News App
//
//  Created by dimas pratama on 18/01/22.
//

import UIKit

extension UIView {
    public func setRoundedCorner(_ radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
    }
}
