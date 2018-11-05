//
//  LoadingIndicator.swift
//  WhenComing
//
//  Created by 장혜준 on 05/11/2018.
//  Copyright © 2018 장혜준. All rights reserved.
//

import UIKit

class LoadingIndicator {
    private(set) var containerView: UIView!
    private(set) var loadingView: UIView!
    private(set) var actIndicator: UIActivityIndicatorView!
    
    static let shared = LoadingIndicator()
    
    private init() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        containerView = UIView()
        containerView.frame = window.frame
        containerView.center = window.center
        containerView.backgroundColor = .lightGray
        
        loadingView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = window.center
        loadingView.backgroundColor = .black
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        actIndicator = UIActivityIndicatorView()
        actIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        actIndicator.style = .whiteLarge
        actIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.width / 2)
        loadingView.addSubview(actIndicator)
        containerView.addSubview(loadingView)
        UIApplication.shared.keyWindow?.addSubview(containerView)
    }
    
    func startIndicator() {
        // containerView.isHidden.
        actIndicator.startAnimating()
    }
    
    func stopIndicator() {
        actIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }
}
