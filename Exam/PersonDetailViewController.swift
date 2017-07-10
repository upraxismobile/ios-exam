//
//  ViewController.swift
//  Exam
//
//  Created by Mark Angelo Noquera on 09/07/2017.
//  Copyright © 2017 Mark Angelo Noquera. All rights reserved.
//

import UIKit
import RxSwift

class PersonDetailViewController: UIViewController {


    @IBOutlet weak var firstNameTf: UITextField!
    @IBOutlet weak var lastNameTf: UITextField!
    @IBOutlet weak var birthdayTf: UITextField!
    @IBOutlet weak var ageTf: UITextField!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var mobileNumberTf: UITextField!
    
    
    var personViewModel: PersonViewModel?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        guard let personViewModel = personViewModel else {
            return
        }
        
        personViewModel.firstNameText.bind(to: firstNameTf.rx.text).addDisposableTo(disposeBag)
        personViewModel.lastNameText.bind(to: lastNameTf.rx.text).addDisposableTo(disposeBag)
        personViewModel.birthDateText.bind(to: birthdayTf.rx.text).addDisposableTo(disposeBag)
        personViewModel.ageText.bind(to: ageTf.rx.text).addDisposableTo(disposeBag)
        personViewModel.emailText.bind(to: emailTf.rx.text).addDisposableTo(disposeBag)
        personViewModel.mobileNumberText.bind(to: mobileNumberTf.rx.text).addDisposableTo(disposeBag)
        
        self.navigationItem.title = "Details"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

