//
//  Person.swift
//  ExamMVVM
//
//  Created by Michelle Conchina on 9/6/17.
//  Copyright © 2017 Michelle Conchina. All rights reserved.
//

import UIKit
import SwiftyJSON

class Person : NSObject {
    var firstName : String?
    var lastName : String?
    var birthDay : String?
    var age : String?
    var emailAddress : String?
    var mobileNumber : String?
    var address : String?
    var contactPerson : String?
    var contactPersonPhoneNumber : String?

}

class PersonHelper {
    let dateFormatter = DateFormatter()
    
    func convertAnyToJSON(list: Any) -> JSON {
        return JSON(list)
    }
    
    func convertToPersonList(list: Any) -> [Person] {
        let listJSON = convertAnyToJSON(list: list)
        var personList = [Person]()
        for (_, value) in listJSON {
            personList.append(convertToPerson(value: value))
        }
        return personList
    }
    
    func convertToPerson(value: JSON) -> Person {
        let person = Person()
        let _firstName = "firstName"
        let _lastName = "lastName"
        let _birthDay = "birthDay"
        let _emailAddress = "emailAddress"
        let _mobileNumber = "mobile"
        let _address = "address"
        let _contactPerson = "contactPerson"
        let _contactPersonPhoneNumber = "contactPersonPhoneNumber"
        
        if let firstName = value[_firstName].string {
            person.firstName = firstName
        }
        if let lastName = value[_lastName].string {
            person.lastName = lastName
        }
        if let birthDay = value[_birthDay].string {
            person.birthDay = birthDay.formattedDateString()
            person.age = birthDay.toAgeString()
        }
        if let emailAddress = value[_emailAddress].string {
            person.emailAddress = emailAddress
        }
        if let mobileNumber = value[_mobileNumber].string {
            person.mobileNumber = mobileNumber
        }
        if let address = value[_address].string {
            person.address = address
        }
        if let contactPerson = value[_contactPerson].string {
            person.contactPerson = contactPerson
        }
        if let contactPersonPhoneNumber = value[_contactPersonPhoneNumber].string {
            person.contactPersonPhoneNumber = contactPersonPhoneNumber
        }
        
        return person
    }
}

//MARK: String
extension String {
    func toAgeString() -> String {
        let ageString = Calendar.current.dateComponents([Calendar.Component.year], from: self.stringToDate(), to: Date()).year
        return String(describing: ageString!)
    }
    
    func stringToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self)!
    }
    
    func formattedDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: self.stringToDate())
    }
}
