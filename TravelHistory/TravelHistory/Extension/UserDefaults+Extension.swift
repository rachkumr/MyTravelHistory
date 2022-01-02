//
//  UserDefaults+Extension.swift
//  TravelHistory
//
//  Created by Raj Kumar on 02/01/22.
//

import Foundation
import UIKit

extension UserDefaults {
    
    static let firstTimeIntoApp = "firstTimeIntoApp"
    
    static func setEnterStatus(status: Bool) {
        self.standard.setValue(status, forKey: firstTimeIntoApp)
    }
    
    static func isFirstTime() -> Bool {
        if let status = self.standard.value(forKey: firstTimeIntoApp) as? Bool {
            return status
        }
        return false
    }
    
}
