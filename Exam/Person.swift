//
//  Person.swift
//  Exam
//
//  Created by Mark Angelo Noquera on 09/07/2017.
//  Copyright © 2017 Mark Angelo Noquera. All rights reserved.
//

import UIKit
import ObjectMapper

class Person: Mappable {
    var firstName: String?
    var lastName: String?
    var birthDate: String?
    var email: String?
    var mobileNumber: String?
    var age: String?
    
    required init?(map: Map){

    }
    
    func mapping(map: Map) {
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        birthDate <- map["birth_day"]
        email   <- map["email"]
        mobileNumber   <- map["mobile_number"]
    }
    
    init(firstName: String, lastName: String, birthDate: String, email: String, mobileNumber: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
        self.email = email
        self.mobileNumber = mobileNumber
    }
    
    
    
}
