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
    private(set) var actIndicator: UIActivityIndicatorView!
    
    static let shared = LoadingIndicator()
    
    private init() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        containerView = UIView()
        containerView.frame = window.frame
        containerView.center = window.center
        containerView.backgroundColor = .gray
        
        actIndicator = UIActivityIndicatorView()
        actIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        actIndicator.style = .whiteLarge
        actIndicator.center = window.center
        containerView.addSubview(actIndicator)
        UIApplication.shared.keyWindow?.addSubview(containerView)
    }
    
    func startIndicator() {
        // containerView.isHidden.
        DispatchQueue.main.async {
            self.actIndicator.startAnimating()
        }
    }
    
    func stopIndicator() {
        DispatchQueue.main.async {
            self.actIndicator.stopAnimating()
            self.containerView.removeFromSuperview()
        }
    }
}
