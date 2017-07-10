//
//  PersonViewModel.swift
//  Exam
//
//  Created by Mark Angelo Noquera on 09/07/2017.
//  Copyright © 2017 Mark Angelo Noquera. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PersonViewModel {
    
    let disposeBag = DisposeBag()
    
    var firstNameText: BehaviorSubject<String>
    var lastNameText: BehaviorSubject<String>
    var birthDateText: BehaviorSubject<String>
    var emailText: BehaviorSubject<String>
    var mobileNumberText: BehaviorSubject<String>
    var ageText: BehaviorSubject<String>
    
    private var person: Person?
    
    init(person: Person) {
        self.person = person

        firstNameText = BehaviorSubject(value: person.firstName!)
        firstNameText
            .asObserver()
            .subscribe(onNext: { firstName in
            person.firstName = firstName
        })
            .addDisposableTo(disposeBag)
    
        
        lastNameText = BehaviorSubject(value: person.lastName!)
        lastNameText
            .asObserver()
            .subscribe(onNext: { lastName in
            person.lastName = lastName
        })
            .addDisposableTo(disposeBag)
        
       
        birthDateText = BehaviorSubject(value: person.birthDate!)
        birthDateText
            .asObserver()
            .subscribe(onNext: { birthDate in
            person.birthDate = birthDate
        })
            .addDisposableTo(disposeBag)
        
        
        emailText = BehaviorSubject(value: person.email!)
        emailText
            .asObserver()
            .subscribe(onNext: {
            email in
            person.email = email
        })
            .addDisposableTo(disposeBag)
        
        mobileNumberText = BehaviorSubject(value: person.mobileNumber!)
        mobileNumberText
            .asObserver()
            .subscribe(onNext: { mobileNumber in
            person.mobileNumber = mobileNumber
        })
            .addDisposableTo(disposeBag)
        
        ageText = BehaviorSubject(value: "0")
        birthDateText = BehaviorSubject(value: String(describing: person.birthDate!))
        birthDateText
            .map({ (birthdate) -> String in
            let ageComponents = Calendar.current.dateComponents([.year], from: self.stringToDate(dateString: "\(birthdate)") as Date, to: Date())
            return "\(ageComponents.year!)"
        })
            .bind(to: ageText).addDisposableTo(disposeBag)
        
    }
    
    func stringToDate(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-mm-yyyy"
        return dateFormatter.date(from: dateString)!
    }
    
}
