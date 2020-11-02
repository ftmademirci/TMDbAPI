//
//  Spinner.swift
//  TMDbAPI
//
//  Created by Fatma Demirci on 21.10.2020.
//

import NVActivityIndicatorView

open class Spinner {
    
    public static let activityData = ActivityData()
    
    public static func spin() {
        NVActivityIndicatorView.DEFAULT_TYPE = .ballScaleRippleMultiple
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.systemGreen
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    public static func stop() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}
