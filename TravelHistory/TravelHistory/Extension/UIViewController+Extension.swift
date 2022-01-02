//
//  UIViewController+Extension.swift
//  TravelHistory
//
//  Created by Rajkumar on 02/01/22.
//

import Foundation
import UIKit
import NVActivityIndicatorView

@objc protocol ActivityIndicatorDelegate {
    func startActivityIndicator()
    func stopActivityIndicator()
}


extension UIViewController : ActivityIndicatorDelegate {
    
    var activityIndicatorHoldingViewTag: Int { return 999999 }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func startActivityIndicator() {
        
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                
                let holdingView = UIView(frame: UIScreen.main.bounds)
                holdingView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)
                holdingView.tag = self.activityIndicatorHoldingViewTag
                
                var activityIndicator : NVActivityIndicatorView!
                let frame = CGRect(x: self.view.frame.size.width / 2 - 30 , y: self.view.frame.size.height / 2 - 20, width: 50, height: 50)
                activityIndicator = NVActivityIndicatorView(frame: frame)
                activityIndicator.type = . lineScale
                activityIndicator.color = .blue
                activityIndicator.startAnimating()
                
                holdingView.addSubview(activityIndicator)
                self.view.addSubview(holdingView) // or use  webView.addSubview(activityIndicator)
                
            }
        }
    }
    
    func stopActivityIndicator() {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                if let holdingView = self.view.subviews.filter({ $0.tag == self.activityIndicatorHoldingViewTag}).first {
                    holdingView.removeFromSuperview()
                }
            }
        }
    }
    
}
