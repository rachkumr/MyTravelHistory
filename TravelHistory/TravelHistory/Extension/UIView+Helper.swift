//
//  UIView+Helper.swift
//  TravelHistory
//
//  Created by Rajkumar on 06/08/21.
//

import Foundation
import UIKit

extension UIView {
    func addBorderColor(borderColor: UIColor, borderWidth: CGFloat, cornerRadius: CGFloat) {
        self.layer.masksToBounds = false;
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
    }
    
}

 
