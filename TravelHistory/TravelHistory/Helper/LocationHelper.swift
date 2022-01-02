//
//  LocationHelper.swift
//  TravelHistory
//
//  Created by Rajkumar on 06/08/21.
//

import Foundation
import Contacts
import CoreLocation

extension CLPlacemark {
     var streetName: String? { thoroughfare }
     var streetNumber: String? { subThoroughfare }
     var city: String? { locality }
     var neighborhood: String? { subLocality }
     var state: String? { administrativeArea }
     var county: String? { subAdministrativeArea }
     var zipCode: String? { postalCode }

    @available(iOS 11.0, *)
    var postalAddressFormatted: String? {
        guard let postalAddress = postalAddress else { return nil }
        return CNPostalAddressFormatter().string(from: postalAddress)
    }
}

extension CLLocation {
    func placemark(completion: @escaping (_ placemark: CLPlacemark?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first, $1) }
    }
}
