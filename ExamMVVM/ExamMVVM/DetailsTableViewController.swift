//
//  DetailsTableViewController.swift
//  ExamMVVM
//
//  Created by Michelle Conchina on 9/8/17.
//  Copyright © 2017 Michelle Conchina. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController {
    
    var personDetails = Person()
    @IBOutlet weak var firstNameLabel: UILabel?
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var birthDayLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var contactPersonLabel: UILabel!
    @IBOutlet weak var contactPersonNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpPersonDetails()
        tableView.tableFooterView = UIView(frame: .zero)
        self.navigationItem.title = "Details"
    }
    
    func setUpPersonDetails() {
        firstNameLabel?.text = personDetails.firstName
        lastNameLabel?.text = personDetails.lastName
        birthDayLabel?.text = personDetails.birthDay
        ageLabel?.text = personDetails.age
        emailAddressLabel?.text = personDetails.emailAddress
        mobileNumberLabel?.text = personDetails.mobileNumber
        addressLabel?.text = personDetails.address
        contactPersonLabel?.text = personDetails.contactPerson
        contactPersonNumberLabel?.text = personDetails.contactPersonPhoneNumber
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
