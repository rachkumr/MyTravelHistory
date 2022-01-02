//
//  LocationModel.swift
//  TravelHistory
//
//  Created by Raj Kumar on 02/01/22.
//

import Foundation
import SwiftyJSON

struct LocationDetails {

    var latitude : Double!
    var longitude : Double!
    var address : String!
    var date : String!

    var dictionary : [String : Any] {
        return ["latitude" : latitude as Any, "longitude" : longitude as Any, "address" : address as Any, "date" : date as Any]
    }
    
    var nsDictionary : NSDictionary {
        return dictionary as NSDictionary
    }
}
