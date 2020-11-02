//
//  UIImageViewExtension.swift
//  TMDbAPI
//
//  Created by Admin on 21.10.2020.
//

import Foundation
import UIKit

extension UIImageView
{
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds

        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] 
        self.addSubview(blurEffectView)
    }
}
