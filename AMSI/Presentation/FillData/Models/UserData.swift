//
//  UserData.swift
//  AMSI
//
//  Created by Anton Petrov on 13.10.2023.
//

import UIKit

struct UserData {
    var image: UIImage?
    var phone: String?
    var email: String?
    var addressLineOne: String?
    var addressLineTwo: String?
    var cityId: Int?
    var countryId: Int?
    var zipCode: String?

    var city: String? {
        guard let cityId else { return nil }
        return CanCity(rawValue: cityId)?.fullName
    }

    var country: String? {
        guard let countryId else { return nil }
        return Country(rawValue: countryId)?.fullName
    }
}
