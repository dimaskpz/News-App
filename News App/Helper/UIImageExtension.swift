//
//  UIImageExtension.swift
//  News App
//
//  Created by dimas pratama on 15/01/22.
//

import UIKit
import Kingfisher

extension UIImageView {
    func enableZoom() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
        isUserInteractionEnabled = true
        addGestureRecognizer(pinchGesture)
    }

    @objc
    private func startZooming(_ sender: UIPinchGestureRecognizer) {
        let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
        guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
        sender.view?.transform = scale
        sender.scale = 1
    }

    func setImage(string: String) {
        guard let url = URL(string: string) else { return }
        self.kf.setImage(with: url)
    }
}
